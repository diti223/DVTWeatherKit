//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation

public struct Weather {
    public let temperature: Celsius
    public let condition: WeatherCondition
    
    public init(temperature: Celsius, condition: WeatherCondition) {
        self.temperature = temperature
        self.condition = condition
    }
}
