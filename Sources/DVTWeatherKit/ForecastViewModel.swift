//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation

public final class ForecastViewModel {
    private static let weekdaySymbols = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    public private(set) var temperatures: [String] = []
    
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
        let forecast = fetchForecastUseCase.fetchForecast()
        temperatures = forecast.map { "\($0)°" }
    }
}


//public struct ForecastDay {
//    public let dayOffset: Int
//    public let temperature: Celsius
//
//    public init(dayOffset: Int, temperature: Celsius) {
//        self.dayOffset = dayOffset
//        self.temperature = temperature
//    }
//}

public protocol FetchForecastUseCase {
    func fetchForecast() -> Forecast
}

public typealias Forecast = [Celsius]