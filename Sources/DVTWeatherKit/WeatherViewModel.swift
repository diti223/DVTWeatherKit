//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import Foundation

public final class WeatherViewModel {
    
    public private(set) var currentTemperature = "-°"
    
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
        let temperature = fetchWeatherUseCase.fetch()
        currentTemperature = "\(temperature)°"
    }
}

