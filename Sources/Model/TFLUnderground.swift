//
//  TFLUnderground.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit


/// Represents a line on the London Underground.
enum TFLUnderground: WikipediaSearchable {
    case bakerloo, central, circle, district, hammersmith, jubilee, metropolitan, northern, piccadilly, victoria, waterloo
    
    static let allValues = [bakerloo, central, circle, district, hammersmith, jubilee, metropolitan, northern, piccadilly, victoria, waterloo]
    
    var color: UIColor {
        switch self {
        case .bakerloo:
            return #colorLiteral(red: 0.537254902, green: 0.3058823529, blue: 0.1411764706, alpha: 1)
        case .central:
            return #colorLiteral(red: 0.862745098, green: 0.1411764706, blue: 0.1215686275, alpha: 1)
        case .circle:
            return #colorLiteral(red: 1, green: 0.8078431373, blue: 0, alpha: 1)
        case .district:
            return #colorLiteral(red: 0, green: 0.4470588235, blue: 0.1607843137, alpha: 1)
        case .hammersmith:
            return #colorLiteral(red: 0.8431372549, green: 0.6, blue: 0.6862745098, alpha: 1)
        case .jubilee:
            return #colorLiteral(red: 0.5254901961, green: 0.5607843137, blue: 0.5960784314, alpha: 1)
        case .metropolitan:
            return #colorLiteral(red: 0.4588235294, green: 0.06274509804, blue: 0.337254902, alpha: 1)
        case .northern:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .piccadilly:
            return #colorLiteral(red: 0, green: 0.09803921569, blue: 0.6588235294, alpha: 1)
        case .victoria:
            return #colorLiteral(red: 0, green: 0.4549019608, blue: 0.8862745098, alpha: 1)
        case .waterloo:
            return #colorLiteral(red: 0.462745098, green: 0.8156862745, blue: 0.7411764706, alpha: 1)
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
