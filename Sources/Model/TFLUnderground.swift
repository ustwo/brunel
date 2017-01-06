//
//  TFLUnderground.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Represents a line on the London Underground.
enum TFLUnderground: WikipediaSearchable {
    case bakerloo, central, circle, district, hammersmith, jubilee, metropolitan, northern, piccadilly, victoria, waterloo
    
    static let allValues = [bakerloo, central, circle, district, hammersmith, jubilee, metropolitan, northern, piccadilly, victoria, waterloo]
    
    var color: UIColor {
        switch self {
        case .bakerloo:
            return UIColor(red: 137.0 / 255.0, green: 78.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
        case .central:
            return UIColor(red: 220.0 / 255.0, green: 36.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
        case .circle:
            return UIColor(red: 255.0 / 255.0, green: 206.0 / 255.0, blue: 0.0, alpha: 1.0)
        case .district:
            return UIColor(red: 0.0, green: 114.0 / 255.0, blue: 41.0 / 255.0, alpha: 1.0)
        case .hammersmith:
            return UIColor(red: 215.0 / 255.0, green: 153.0 / 255.0, blue: 175.0 / 255.0, alpha: 1.0)
        case .jubilee:
            return UIColor(red: 134.0 / 255.0, green: 143.0 / 255.0, blue: 152.0 / 255.0, alpha: 1.0)
        case .metropolitan:
            return UIColor(red: 117.0 / 255.0, green: 16.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
        case .northern:
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case .piccadilly:
            return UIColor(red: 0.0, green: 25.0 / 255.0, blue: 168.0 / 255.0, alpha: 1.0)
        case .victoria:
            return UIColor(red:0.0, green: 116.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        case .waterloo:
            return UIColor(red: 118.0 / 255.0, green: 208.0 / 255.0, blue: 189.0 / 255.0, alpha: 1.0)
        }
    }
    
    var description: String {
        switch self {
        case .bakerloo:
            return "Bakerloo"
        case .central:
            return "Central"
        case .circle:
            return "Circle"
        case .district:
            return "District"
        case .hammersmith:
            return "Hammersmith & City"
        case .jubilee:
            return "Jubilee"
        case .metropolitan:
            return "Metropolitan"
        case .northern:
            return "Northern"
        case .piccadilly:
            return "Piccadilly"
        case .victoria:
            return "Victoria"
        case .waterloo:
            return "Waterloo & City"
        }
    }
    
    var wikipediaPageName: String {
        switch self {
        case .bakerloo:
            return "Bakerloo_line"
        case .central:
            return "Central_line"
        case .circle:
            return "Circle_line_(London_Underground)"
        case .district:
            return "District_line"
        case .hammersmith:
            return "Hammersmith_&_City_line"
        case .jubilee:
            return "Jubilee_line"
        case .metropolitan:
            return "Metropolitan_line"
        case .northern:
            return "Northern_line"
        case .piccadilly:
            return "Piccadilly_line"
        case .victoria:
            return "Victoria_line"
        case .waterloo:
            return "Waterloo_&_City_line"
        }
    }
}
