//
//  TFLModes.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Represents a mode of transportation on TfL's network.
enum TFLModes: String, CustomStringConvertible {
    case Bus            = "bus"
    case CableCar       = "cable-car"
    case DLR            = "dlr"
    case NationalRail   = "national-rail"
    case Overground     = "overground"
    case River          = "river-bus"
    case TFLRail        = "tflrail"
    case Tram           = "tram"
    case Underground    = "tube"
    
    static let allValues = [Bus, CableCar, DLR, NationalRail, Overground, River, TFLRail, Tram, Underground]
    
    var description: String {
        switch self {
        case .Bus:
            return NSLocalizedString("Bus", comment: "")
        case .CableCar:
            return NSLocalizedString("Cable Car", comment: "")
        case .DLR:
            return NSLocalizedString("Docklands Light Railway", comment: "")
        case .NationalRail:
            return NSLocalizedString("National Rail", comment: "")
        case .Overground:
            return NSLocalizedString("Overground", comment: "")
        case .River:
            return NSLocalizedString("River", comment: "")
        case .TFLRail:
            return NSLocalizedString("TfL Rail", comment: "")
        case .Tram:
            return NSLocalizedString("Tram", comment: "")
        case .Underground:
            return NSLocalizedString("Underground", comment: "")
        }
    }
    
    var color: UIColor {
        switch self {
        case .Bus:
            return UIColor(red: 220.0 / 255.0, green: 36.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
        case .CableCar:
            return UIColor(red: 217.0 / 255.0, green: 0.0, blue: 42.0 / 255.0, alpha: 1.0)
        case .DLR:
            return UIColor(red: 0.0, green: 175.0 / 255.0, blue: 173.0 / 255.0, alpha: 1.0)
        case .NationalRail:
            return UIColor(red: 21.0 / 255.0, green: 91.0 / 255.0, blue: 149.0 / 255.0, alpha: 1.0)
        case .Overground:
            return UIColor(red: 232.0 / 255.0, green: 119.0 / 255.0, blue: 34.0 / 255.0, alpha: 1.0)
        case .River:
            return UIColor(red: 0.0, green: 160.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        case .TFLRail:
            return UIColor(red: 114.0 / 255.0, green: 86.0 / 255.0, blue: 165.0 / 255.0, alpha: 1.0)
        case .Tram:
            return UIColor(red: 0.0, green: 189.0 / 255.0, blue: 25.0 / 255.0, alpha: 1.0)
        case .Underground:
            return UIColor(red: 0.0, green: 25.0 / 255.0, blue: 168.0 / 255.0, alpha: 1.0)
        }
    }
}
