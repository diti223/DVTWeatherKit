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
        
        do {
            let currentClujWeather = try await sut.fetch()
            debugPrint(currentClujWeather)
        } catch {
            XCTFail("Expected to decode response but got \(error)")
        }
    }
}
