//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import Foundation

public final class WeatherViewModel {
    
    private var currentWeather: Weather?
    public var currentTemperature: String {
        guard let currentWeather else {
            return "-°"
        }
        return "\(currentWeather.temperature)°"
    }
    
    public var currentCondition: String? {
        switch currentWeather?.condition {
            case .sunny:
                "Sunny"
            case .raining:
                "Rainy"
            case .cloudy:
                "Cloudy"
            default:
                nil
        }
    }
    
    public let minTemperature = "-°"
    public let maxTemperature = "-°"
    
    let fetchWeatherUseCase: FetchWeatherUseCase
    
    public init(
        calendar: Calendar = .current,
        date: Date = Date(),
        fetchWeatherUseCase: FetchWeatherUseCase
    ) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }
    
    public func viewDidAppear() async {
        currentWeather = fetchWeatherUseCase.fetch()
    }
}

