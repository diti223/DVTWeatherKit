//
//  DemoFetchForecastUseCase.swift
//  DVTWeather
//
//  Created by Adrian Bilescu on 30.01.2024.
//

import Foundation
import DVTWeatherKit

struct DemoFetchForecastUseCase: FetchForecastUseCase {
    func fetchForecast() async -> Forecast {
        [
            Weather(temperature: 20, condition: .sunny),
            Weather(temperature: 23, condition: .sunny),
            Weather(temperature: 27, condition: .sunny),
            Weather(temperature: 28, condition: .sunny),
            Weather(temperature: 30, condition: .sunny)
        ]
    }
}
