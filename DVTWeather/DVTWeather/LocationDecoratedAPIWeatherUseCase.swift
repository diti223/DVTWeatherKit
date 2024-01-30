//
//  LocationalWeatherUseCaseAdapter.swift
//  DVTWeather
//
//  Created by Adrian Bilescu on 30.01.2024.
//

import Foundation
import CoreLocation
import DVTWeatherKit

class LocationDecoratedAPIWeatherUseCase: NSObject, CLLocationManagerDelegate, FetchWeatherUseCase {
    private let locationManager = CLLocationManager()
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
        super.init()
    }
    
    var continuation: CheckedContinuation<(Double, Double), Error>?
    func fetch() async -> Weather {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let location = try! await withCheckedThrowingContinuation { [weak self] continuation in
            self?.continuation = continuation
        }
        
        let useCase = APIFetchCurrentWeatherUseCase(
            httpClient: httpClient,
            location: location
        )
        
        let weather = try! await useCase.fetch()
        return weather
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            continuation?.resume(
                returning: (
                    lastLocation.coordinate.latitude,
                    lastLocation.coordinate.longitude
                )
            )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
    }
}
