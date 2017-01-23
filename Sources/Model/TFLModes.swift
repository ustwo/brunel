//
//  TFLModes.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
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
            return #colorLiteral(red: 0.862745098, green: 0.1411764706, blue: 0.1215686275, alpha: 1)
        case .CableCar:
            return #colorLiteral(red: 0.8509803922, green: 0, blue: 0.1647058824, alpha: 1)
        case .DLR:
            return #colorLiteral(red: 0, green: 0.6862745098, blue: 0.6784313725, alpha: 1)
        case .NationalRail:
            return #colorLiteral(red: 0.08235294118, green: 0.3568627451, blue: 0.5843137255, alpha: 1)
        case .Overground:
            return #colorLiteral(red: 0.9098039216, green: 0.4666666667, blue: 0.1333333333, alpha: 1)
        case .River:
            return #colorLiteral(red: 0, green: 0.6274509804, blue: 0.8862745098, alpha: 1)
        case .TFLRail:
            return #colorLiteral(red: 0.4470588235, green: 0.337254902, blue: 0.6470588235, alpha: 1)
        case .Tram:
            return #colorLiteral(red: 0, green: 0.7411764706, blue: 0.09803921569, alpha: 1)
        case .Underground:
            return #colorLiteral(red: 0, green: 0.09803921569, blue: 0.6588235294, alpha: 1)
        }
    }
}
