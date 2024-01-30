//
//  File.swift
//  
//
//  Created by Adrian Bilescu on 30.01.2024.
//

import Foundation
import SwiftUI

public typealias HexColor = String

public extension Color {
    init(hexString: HexColor) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let red, green, blue: UInt64
        switch hex.count {
            case 6: // RGB
                (red, green, blue) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB
                (red, green, blue) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (red, green, blue) = (0, 0, 0)
        }
        
        self.init(
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255
        )
    }
}
