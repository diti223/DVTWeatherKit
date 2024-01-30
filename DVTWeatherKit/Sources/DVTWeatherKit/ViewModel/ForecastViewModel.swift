//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation
import Combine

public final class ForecastViewModel: ObservableObject {
    private static let weekdaySymbols = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    public var temperatures: [String] {
        forecast.map(\.temperature).map { "\($0)°" }
    }
    
    public var conditions: [WeatherCondition] {
        forecast.map(\.condition)
    }
    
    @Published private(set) var forecast = Forecast()
    
    public let forecastDays: [String]
    
    let fetchForecastUseCase: FetchForecastUseCase
    
    public init(
        calendar: Calendar = .current,
        date: Date = Date(),
        fetchForecastUseCase: FetchForecastUseCase
    ) {
        self.fetchForecastUseCase = fetchForecastUseCase
        
        let currentWeekday = calendar.dateComponents([.weekday], from: date).weekday!
        let weekdaySymbolIndex = currentWeekday - 1
        forecastDays = (1...5).map { offset in
            Self.weekdaySymbols[(weekdaySymbolIndex + offset) % 7]
        }
    }
    
    public func viewDidAppear() async {
        let forecast = await fetchForecastUseCase.fetchForecast()
        self.forecast = forecast
//        temperatures = forecast.map { "\($0)°" }
//        conditions = forecast.map(\.condition)
    }
}

