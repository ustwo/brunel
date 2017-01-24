//
//  TFLNationalRail.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit


/// Represents a Network Rail line.
enum TFLNationalRail {
    case arrivaWales, c2C, chiltern, crossCounty, eastMidlands, firstGreatWestern, firstHull, firstTransPennine, gatwick, grandCentral, greaterAnglia, greatNorthern, heathrowConnect, heathrowExpress, island, londonMidland, merseyrail, northern, scotRail, southeastern, southern, southWest, thameslink, virgin, virginEastCoast
    
    static let allValues = [arrivaWales, c2C, chiltern, crossCounty, eastMidlands, firstGreatWestern, firstHull, firstTransPennine, gatwick, grandCentral, greaterAnglia, greatNorthern, heathrowConnect, heathrowExpress, island, londonMidland, merseyrail, northern, scotRail, southeastern, southern, southWest, thameslink, virgin, virginEastCoast]
    
    var color: UIColor {
        switch self {
        case .arrivaWales:
            return #colorLiteral(red: 0.1882352941, green: 0.7725490196, blue: 0.7215686275, alpha: 1)
        case .c2C:
            return #colorLiteral(red: 0.7058823529, green: 0, blue: 0.4862745098, alpha: 1)
        case .chiltern:
            return #colorLiteral(red: 0, green: 0.7490196078, blue: 1, alpha: 1)
        case .crossCounty:
            return #colorLiteral(red: 0.4, green: 0.05882352941, blue: 0.1294117647, alpha: 1)
        case .eastMidlands:
            return #colorLiteral(red: 1, green: 0.6470588235, blue: 0, alpha: 1)
        case .firstGreatWestern:
            return #colorLiteral(red: 0.03921568627, green: 0.2862745098, blue: 0.2431372549, alpha: 1)
        case .firstHull:
            return #colorLiteral(red: 0.8705882353, green: 0, blue: 0.3607843137, alpha: 1)
        case .firstTransPennine:
            return #colorLiteral(red: 0.003921568627, green: 0.01176470588, blue: 0.5215686275, alpha: 1)
        case .gatwick:
            return #colorLiteral(red: 0.9490196078, green: 0, blue: 0.09019607843, alpha: 1)
        case .grandCentral:
            return #colorLiteral(red: 0.1725490196, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
        case .greaterAnglia:
            return #colorLiteral(red: 0.8431372549, green: 0.01568627451, blue: 0.1568627451, alpha: 1)
        case .greatNorthern:
            return #colorLiteral(red: 0, green: 0.6588235294, blue: 0.8862745098, alpha: 1)
        case .heathrowConnect:
            return #colorLiteral(red: 0.968627451, green: 0.5607843137, blue: 0.1176470588, alpha: 1)
        case .heathrowExpress:
            return #colorLiteral(red: 0.3254901961, green: 0.1803921569, blue: 0.3882352941, alpha: 1)
        case .island:
            return #colorLiteral(red: 0.1176470588, green: 0.5647058824, blue: 1, alpha: 1)
        case .londonMidland:
            return #colorLiteral(red: 0.462745098, green: 0.7058823529, blue: 0.1215686275, alpha: 1)
        case .merseyrail:
            return #colorLiteral(red: 1, green: 0.9490196078, blue: 0, alpha: 1)
        case .northern:
            return #colorLiteral(red: 0.5450980392, green: 0, blue: 1, alpha: 1)
        case .scotRail:
            return #colorLiteral(red: 0, green: 0.5019607843, blue: 0, alpha: 1)
        case .southeastern:
            return #colorLiteral(red: 0, green: 0.6862745098, blue: 0.9098039216, alpha: 1)
        case .southern:
            return #colorLiteral(red: 0.5490196078, green: 0.7764705882, blue: 0.2431372549, alpha: 1)
        case .southWest:
            return #colorLiteral(red: 0.9333333333, green: 0.1098039216, blue: 0.137254902, alpha: 1)
        case .thameslink:
            return #colorLiteral(red: 0.9098039216, green: 0.2901960784, blue: 0.7294117647, alpha: 1)
        case .virgin:
            return #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        case .virginEastCoast:
            return #colorLiteral(red: 0.8431372549, green: 0.05490196078, blue: 0.2078431373, alpha: 1)
        }
    }
    
    var description: String {
        switch self {
        case .arrivaWales:
            return "Arriva Trains Wales"
        case .c2C:
            return "c2c"
        case .chiltern:
            return "Chiltern Railways"
        case .crossCounty:
            return "Cross Country"
        case .eastMidlands:
            return "East Midlands Trains"
        case .firstGreatWestern:
            return "First Great Western"
        case .firstHull:
            return "First Hull Trains"
        case .firstTransPennine:
            return "First TransPennine Express"
        case .gatwick:
            return "Gatwick Express"
        case .grandCentral:
            return "Grand Central"
        case .greaterAnglia:
            return "Greater Anglia"
        case .greatNorthern:
            return "Great Northern"
        case .heathrowConnect:
            return "Heathrow Connect"
        case .heathrowExpress:
            return "Heathrow Express"
        case .island:
            return "Island Line"
        case .londonMidland:
            return "London Midland"
        case .merseyrail:
            return "Merseyrail"
        case .northern:
            return "Northern Rail"
        case .scotRail:
            return "ScotRail"
        case .southeastern:
            return "Southeastern"
        case .southern:
            return "Southern"
        case .southWest:
            return "South West Trains"
        case .thameslink:
            return "Thameslink"
        case .virgin:
            return "Virgin Trains"
        case .virginEastCoast:
            return "Virgin Trains East Coast"
        }
    }
}
