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
    var body: some Scene {
        WindowGroup {
            WeatherView(
                viewModel: WeatherViewModel(
                    calendar: .current,
                    date: Date(),
                    fetchWeatherUseCase: DemoFetchWeatherUseCase()
                )
            )
        }
    }
}

struct DemoFetchWeatherUseCase: FetchWeatherUseCase {
    func fetch() async -> Weather {
        Weather(temperature: -1, condition: .sunny)
    }
}
