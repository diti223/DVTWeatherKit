//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation
import XCTest
import DVTWeatherKit


final class APIFetchCurrentWeatherUseCaseTests: XCTestCase {
    func testValidResponse() async throws {
        let client = HTTPClientStub()
        let location: (latitude: Double, longitude: Double) = (45.0, 25)
        let testDataCodes: [(given: Int, expected: WeatherCondition)] = [
            (given: 800, expected: .sunny),
            (given: 803, expected: .cloudy),
            (given: 300, expected: .rainy),
            (given: 500, expected: .rainy),
            (given: 1000, expected: .cloudy),
        ]
        
        for testDataCode in testDataCodes {
            
            let givenJSON = """
{
    "weather": [
        {
            "id": \(testDataCode.given)
        }
    ],
    "main": {
        "temp": 25,
        "temp_min": 18,
        "temp_max": 32
    }
}
""".data(using: .utf8)!
            let path = "/data/2.5/weather/"
            let queryItems = [
                URLQueryItem(name: "lat", value: "\(location.latitude)"),
                URLQueryItem(name: "lon", value: "\(location.longitude)"),
                URLQueryItem(name: "units", value: "metric")
            ]
            let request = HTTPRequest(method: .get, path: path, queryItems: queryItems)
            client.stub(
                for: request,
                response: givenJSON
            )
            
            let sut = APIFetchCurrentWeatherUseCase(httpClient: client, location: location)
            
            do {
                let extremesWeather = try await sut.fetch()
                XCTAssertEqual(extremesWeather.weather.temperature, 25)
                XCTAssertEqual(extremesWeather.weather.condition, testDataCode.expected)
                XCTAssertEqual(extremesWeather.maxTemperature, 32)
                XCTAssertEqual(extremesWeather.minTemperature, 18)
            } catch {
                XCTFail("Did not expect to throw error. Received \(error)")
            }
        }
        
    }
}
