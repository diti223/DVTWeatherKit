//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import Foundation

public final class WeatherViewModel {
    private static let weekdaySymbols = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    public private(set) var currentTemperature = "-°"
    public let minTemperature = "-°"
    public let maxTemperature = "-°"
    
    public let forecastDays: [String]
    
    
    let fetchWeatherUseCase: FetchWeatherUseCase
    
    public init(calendar: Calendar = .current, date: Date = Date(), fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
        
        let currentWeekday = calendar.dateComponents([.weekday], from: date).weekday!
        let weekdaySymbolIndex = currentWeekday - 1
        forecastDays = (1...5).map { offset in
            Self.weekdaySymbols[(weekdaySymbolIndex + offset) % 7]
        }
    }
    
    public func viewDidAppear() async {
        let temperature = fetchWeatherUseCase.fetch()
        currentTemperature = "\(temperature)°"
    }
}
