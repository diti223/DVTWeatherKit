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
    let httpClient = URLSessionClient(
        baseURL: URL(string: "https://api.openweathermap.org")!,
        session: .shared
    )
    
    var body: some Scene {
        WindowGroup {
            WeatherView(
                viewModel: WeatherViewModel(
                    calendar: calendar,
                    date: date,
                    fetchWeatherUseCase: LocationDecoratedAPIWeatherUseCase(
                        httpClient: httpClient.addLog().addAuthorization(
                            apiKey: APIKey.demo
                        )
                    )
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
