//
//  ColorManager.swift
//  CSDS395
//
//  Created by Sylvie Dyer on 11/3/23.
//

import Swift
import Foundation
import SwiftUI

// class to return colors for application theme
class ColorManager {
    
    func getLavendar() -> Color {
        return getColor(hex: "#C2A0E8")
    }
    
    func getLightLavendar() -> Color {
        return getColor(hex: "#DED7FA")
    }
    
    func getLightGreyLavendar() -> Color {
        return getColor(hex: "#c7c1e1")
    }
    
    func getLightGreen() -> Color {
        return getColor(hex: "#EEF5E1")
    }
    
    
    func getMidGreen() -> Color {
        return getColor(hex: "#B2D4AB")
    }
    
    func getDarkGreen() -> Color {
        return getColor(hex: "#93BEA4")
    }
    
    func getColor(hex: String) -> Color{
        
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        return Color.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

