//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import Foundation

public typealias Celsius = Int

public protocol FetchWeatherUseCase {
    func fetch() -> Weather
}


public enum WeatherCondition {
    case sunny
}

public struct Weather {
    public let temperature: Celsius
    public let condition: WeatherCondition
    
    public init(temperature: Celsius, condition: WeatherCondition) {
        self.temperature = temperature
        self.condition = condition
    }
}
