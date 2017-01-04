//
//  TFLNationalRail.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Represents a Network Rail line.
enum TFLNationalRail {
    case arrivaWales, c2C, chiltern, crossCounty, eastMidlands, firstGreatWestern, firstHull, firstTransPennine, gatwick, grandCentral, greaterAnglia, greatNorthern, heathrowConnect, heathrowExpress, island, londonMidland, merseyrail, northern, scotRail, southeastern, southern, southWest, thameslink, virgin, virginEastCoast
    
    static let allValues = [arrivaWales, c2C, chiltern, crossCounty, eastMidlands, firstGreatWestern, firstHull, firstTransPennine, gatwick, grandCentral, greaterAnglia, greatNorthern, heathrowConnect, heathrowExpress, island, londonMidland, merseyrail, northern, scotRail, southeastern, southern, southWest, thameslink, virgin, virginEastCoast]
    
    var color: UIColor {
        switch self {
        case .arrivaWales:
            return UIColor(red: 48.0 / 255.0, green: 197.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
        case .c2C:
            return UIColor(red: 180.0 / 255.0, green: 0.0, blue: 124.0 / 255.0, alpha: 1.0)
        case .chiltern:
            return UIColor(red: 0.0, green: 191.0 / 255.0, blue: 1.0, alpha: 1.0)
        case .crossCounty:
            return UIColor(red: 102.0 / 255.0, green: 15.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
        case .eastMidlands:
            return UIColor(red: 255.0 / 255.0, green: 165.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        case .firstGreatWestern:
            return UIColor(red: 10.0 / 255.0, green: 73.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)
        case .firstHull:
            return UIColor(red: 222.0 / 255.0, green: 0.0, blue: 92.0 / 255.0, alpha: 1.0)
        case .firstTransPennine:
            return UIColor(red: 1.0 / 255.0, green: 3.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        case .gatwick:
            return UIColor(red: 242.0 / 255.0, green: 0.0, blue: 23.0 / 255.0, alpha: 1.0)
        case .grandCentral:
            return UIColor(red: 44.0 / 255.0, green: 56.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0)
        case .greaterAnglia:
            return UIColor(red: 215.0 / 255.0, green: 4.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
        case .greatNorthern:
            return UIColor(red: 0.0, green: 168.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        case .heathrowConnect:
            return UIColor(red: 247.0 / 255.0, green: 143.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
        case .heathrowExpress:
            return UIColor(red: 83.0 / 255.0, green: 46.0 / 255.0, blue: 99.0 / 255.0, alpha: 1.0)
        case .island:
            return UIColor(red: 30.0 / 255.0, green: 144.0 / 255.0, blue: 1.0, alpha: 1.0)
        case .londonMidland:
            return UIColor(red: 118.0 / 255.0, green: 180.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
        case .merseyrail:
            return UIColor(red: 1.0, green: 242.0 / 255.0, blue: 0.0, alpha: 1.0)
        case .northern:
            return UIColor(red: 139.0 / 255.0, green: 0.0, blue: 1.0, alpha: 1.0)
        case .scotRail:
            return UIColor(red: 0.0, green: 128.0 / 255.0, blue: 0.0, alpha: 1.0)
        case .southeastern:
            return UIColor(red: 0.0, green: 175.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
        case .southern:
            return UIColor(red: 140.0 / 255.0, green: 198.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)
        case .southWest:
            return UIColor(red: 238.0 / 255.0, green: 28.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
        case .thameslink:
            return UIColor(red: 232.0 / 255.0, green: 74.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0)
        case .virgin:
            return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case .virginEastCoast:
            return UIColor(red: 215.0 / 255.0, green: 14.0 / 255.0, blue: 53.0 / 255.0, alpha: 1.0)
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
