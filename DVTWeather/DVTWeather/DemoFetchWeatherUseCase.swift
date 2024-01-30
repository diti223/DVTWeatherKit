//
//  DemoFetchWeatherUseCase.swift
//  DVTWeather
//
//  Created by Adrian Bilescu on 30.01.2024.
//

import Foundation
import DVTWeatherKit

struct DemoFetchWeatherUseCase: FetchWeatherUseCase {
    func fetch() async -> Weather {
        Weather(temperature: 25, condition: .sunny)
    }
}
