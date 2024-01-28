//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation
import DVTWeatherKit
import XCTest






final class DVTWeatherKitAPITests: XCTestCase {
    func testCurrentConditions() async throws {
        let httpClient = URLSessionClient(
            baseURL: URL(string: "https://api.openweathermap.org")!,
            session: .shared
        ).addLog()
            .addAuthorization(apiKey: APIKey.testing)

        let location = (latitude: 46.76936371348493, longitude: 23.590017678216558)
        let sut = APIFetchCurrentWeatherUseCase(
            httpClient: httpClient,
            location: location
        )
        
        let currentClujWeather = try await sut.fetch()
        
        XCTAssertEqual(currentClujWeather.condition, .cloudy)
        XCTAssertEqual(currentClujWeather.temperature, 2)
    }
}
