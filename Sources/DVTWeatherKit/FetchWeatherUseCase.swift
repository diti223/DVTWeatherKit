//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 27.01.2024.
//

import Foundation

public typealias Celsius = Int

public protocol FetchWeatherUseCase {
    func fetch() -> Celsius
}
