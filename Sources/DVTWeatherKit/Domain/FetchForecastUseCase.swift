//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 28.01.2024.
//

import Foundation

public protocol FetchForecastUseCase {
    func fetchForecast() -> Forecast
}
