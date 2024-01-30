//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 30.01.2024.
//

import Foundation

public struct PresentationWeather {
    public let temperature: String
    public let condition: WeatherCondition
    public let minTemperature: String
    public let maxTemperature: String
    
    public var conditionName: String {
        switch condition {
            case .sunny:
                "Sunny"
            case .rainy:
                "Rainy"
            case .cloudy:
                "Cloudy"
        }
    }
}
