//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation

public struct APIFetchCurrentWeatherUseCase {
    public let httpClient: HTTPClient
    public let location: (latitude: Double, longitude: Double)
    
    public init(httpClient: HTTPClient, location: (latitude: Double, longitude: Double)) {
        self.httpClient = httpClient
        self.location = location
    }
    
    public func fetch() async throws -> Weather {
        let queryItems = [
            URLQueryItem(name: "lat", value: "\(location.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.longitude)"),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        let request = HTTPRequest(
            method: .get,
            path: "data/2.5/weather",
            queryItems: queryItems
        )
        
        let response = try await httpClient.data(request)
        
        let jsonDecoder = JSONDecoder()
        let apiResponse = try jsonDecoder.decode(APIFetchCurrentWeatherResponse.self, from: response.body)
        
        let weather = apiResponse.toWeather()
        
        return weather
    }
}

struct APIFetchCurrentWeatherResponse: Decodable {
    //    struct APIWeather: Decodable {
    //        let main: String
    //    }
    struct Main: Decodable {
        let temp: Double
    }
    
    //    let weather: APIWeather
    let main: Main
    
    func toWeather() -> Weather {
        let weather = Weather(temperature: Celsius(main.temp), condition: .sunny)
        return weather
    }
}
