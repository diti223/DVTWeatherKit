//
//  DVTWeatherApp.swift
//  DVTWeather
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import SwiftUI
import DVTWeatherKit

@main
struct DVTWeatherApp: App {
    let calendar = Calendar.current
    let date = Date()
    var body: some Scene {
        WindowGroup {
            WeatherView(
                viewModel: WeatherViewModel(
                    calendar: calendar,
                    date: date,
                    fetchWeatherUseCase: DemoFetchWeatherUseCase()
                ),
                forecastViewModel: ForecastViewModel(
                    calendar: calendar,
                    date: date,
                    fetchForecastUseCase: DemoFetchForecastUseCase()
                )
            )
        }
    }
}

struct DemoFetchWeatherUseCase: FetchWeatherUseCase {
    func fetch() async -> Weather {
        Weather(temperature: 25, condition: .sunny)
    }
}

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
    
