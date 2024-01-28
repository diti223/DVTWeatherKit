//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation
import DVTWeatherKit
import XCTest

struct APIFetchCurrentWeatherUseCase {
    var session: URLSession = .shared
    let location: (Double, Double)
    
    func fetch() async throws -> Weather {
        return Weather(temperature: -300, condition: .sunny)
    }
}

final class DVTWeatherKitAPITests: XCTestCase {
    func testCurrentConditions() async throws {
        let location = (latitude: 46.76936371348493, longitude: 23.590017678216558)
        let sut = APIFetchCurrentWeatherUseCase(location: location)
        
        let currentClujWeather = try await sut.fetch()
        
        XCTAssertEqual(currentClujWeather.condition, .cloudy)
        XCTAssertEqual(currentClujWeather.temperature, 2)
    }
}
