//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 30.01.2024.
//

import Foundation

public struct ExtremesWeather {
    public let weather: Weather
    public let minTemperature: Celsius
    public let maxTemperature: Celsius
    
    public init(weather: Weather, minTemperature: Celsius, maxTemperature: Celsius) {
        self.weather = weather
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
    }
}
