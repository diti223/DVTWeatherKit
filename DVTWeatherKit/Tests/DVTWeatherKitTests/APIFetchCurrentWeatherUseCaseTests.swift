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
        let givenJSON = """
{
    "weather": [
        {
            "main": "Rain"
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
            let weather = try await sut.fetch()
            XCTAssertEqual(weather.temperature, 25)
        } catch {
            XCTFail("Did not expect to throw error. Received \(error)")
        }
        
    }
}
