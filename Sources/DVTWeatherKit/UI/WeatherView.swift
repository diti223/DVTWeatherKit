//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    var body: some View {
        VStack {
            Text(viewModel.currentTemperature)
            if let condition = viewModel.currentCondition {
                Text(condition)
            }
        }
        
    }
}


#Preview {
    VStack {
        CurrentWeatherView(
            viewModel: WeatherViewModel(
                fetchWeatherUseCase: PreviewFetchWeatherUseCase(weather: .sunny)
            )
        )
        CurrentWeatherView(
            viewModel: WeatherViewModel(
                fetchWeatherUseCase: PreviewFetchWeatherUseCase(weather: .cloudy)
            )
        )
        CurrentWeatherView(
            viewModel: WeatherViewModel(
                fetchWeatherUseCase: PreviewFetchWeatherUseCase(weather: .rainy)
            )
        )
    }.padding(200)

}

extension Weather {
    static let sunny = Weather(temperature: 25, condition: .sunny)
    static let cloudy = Weather(temperature: -1, condition: .cloudy)
    static let rainy = Weather(temperature: 12, condition: .rainy)
}

struct PreviewFetchWeatherUseCase: FetchWeatherUseCase {
    let weather: Weather
    func fetch() async -> Weather {
        weather
    }
}
