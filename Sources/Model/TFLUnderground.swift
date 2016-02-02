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
    case Bakerloo, Central, Circle, District, Hammersmith, Jubilee, Metropolitan, Northern, Piccadilly, Victoria, Waterloo
    
    static let allValues = [Bakerloo, Central, Circle, District, Hammersmith, Jubilee, Metropolitan, Northern, Piccadilly, Victoria, Waterloo]
    
    var color: UIColor {
        switch self {
        case .Bakerloo:
            return UIColor(red: 137.0 / 255.0, green: 78.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
        case .Central:
            return UIColor(red: 220.0 / 255.0, green: 36.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
        case .Circle:
            return UIColor(red: 255.0 / 255.0, green: 206.0 / 255.0, blue: 0.0, alpha: 1.0)
        case .District:
            return UIColor(red: 0.0, green: 114.0 / 255.0, blue: 41.0 / 255.0, alpha: 1.0)
        case .Hammersmith:
            return UIColor(red: 215.0 / 255.0, green: 153.0 / 255.0, blue: 175.0 / 255.0, alpha: 1.0)
        case .Jubilee:
            return UIColor(red: 134.0 / 255.0, green: 143.0 / 255.0, blue: 152.0 / 255.0, alpha: 1.0)
        case .Metropolitan:
            return UIColor(red: 117.0 / 255.0, green: 16.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
        case .Northern:
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case .Piccadilly:
            return UIColor(red: 0.0, green: 25.0 / 255.0, blue: 168.0 / 255.0, alpha: 1.0)
        case .Victoria:
            return UIColor(red:0.0, green: 116.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        case .Waterloo:
            return UIColor(red: 118.0 / 255.0, green: 208.0 / 255.0, blue: 189.0 / 255.0, alpha: 1.0)
        }
    }
    
    var description: String {
        switch self {
        case .Bakerloo:
            return "Bakerloo"
        case .Central:
            return "Central"
        case .Circle:
            return "Circle"
        case .District:
            return "District"
        case .Hammersmith:
            return "Hammersmith & City"
        case .Jubilee:
            return "Jubilee"
        case .Metropolitan:
            return "Metropolitan"
        case .Northern:
            return "Northern"
        case .Piccadilly:
            return "Piccadilly"
        case .Victoria:
            return "Victoria"
        case .Waterloo:
            return "Waterloo & City"
        }
    }
    
    var wikipediaPageName: String {
        switch self {
        case .Bakerloo:
            return "Bakerloo_line"
        case .Central:
            return "Central_line"
        case .Circle:
            return "Circle_line_(London_Underground)"
        case .District:
            return "District_line"
        case .Hammersmith:
            return "Hammersmith_&_City_line"
        case .Jubilee:
            return "Jubilee_line"
        case .Metropolitan:
            return "Metropolitan_line"
        case .Northern:
            return "Northern_line"
        case .Piccadilly:
            return "Piccadilly_line"
        case .Victoria:
            return "Victoria_line"
        case .Waterloo:
            return "Waterloo_&_City_line"
        }
    }
}
