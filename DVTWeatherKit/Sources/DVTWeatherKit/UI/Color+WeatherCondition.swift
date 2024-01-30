//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 30.01.2024.
//

import SwiftUI

extension Color {
    static let sunny = Color(hexString: "47AB2F")
    static let cloudy = Color(hexString: "54717A")
    static let rainy = Color(hexString: "57575D")
    
    init(condition: WeatherCondition) {
        switch condition {
            case .sunny:
                self = .sunny
            case .cloudy:
                self = .cloudy
            case .rainy:
                self = .rainy
        }
    }
}
