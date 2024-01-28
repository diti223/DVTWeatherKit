//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import Foundation

public protocol FetchWeatherUseCase {
    func fetch() async -> Weather
}
