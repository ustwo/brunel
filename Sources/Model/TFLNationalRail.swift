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
    case ArrivaWales, C2C, Chiltern, CrossCounty, EastMidlands, FirstGreatWestern, FirstHull, FirstTransPennine, Gatwick, GrandCentral, GreaterAnglia, GreatNorthern, HeathrowConnect, HeathrowExpress, Island, LondonMidland, Merseyrail, Northern, ScotRail, Southeastern, Southern, SouthWest, Thameslink, Virgin, VirginEastCoast
    
    static let allValues = [ArrivaWales, C2C, Chiltern, CrossCounty, EastMidlands, FirstGreatWestern, FirstHull, FirstTransPennine, Gatwick, GrandCentral, GreaterAnglia, GreatNorthern, HeathrowConnect, HeathrowExpress, Island, LondonMidland, Merseyrail, Northern, ScotRail, Southeastern, Southern, SouthWest, Thameslink, Virgin, VirginEastCoast]
    
    var color: UIColor {
        switch self {
        case .ArrivaWales:
            return UIColor(red: 48.0 / 255.0, green: 197.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
        case .C2C:
            return UIColor(red: 180.0 / 255.0, green: 0.0, blue: 124.0 / 255.0, alpha: 1.0)
        case .Chiltern:
            return UIColor(red: 0.0, green: 191.0 / 255.0, blue: 1.0, alpha: 1.0)
        case .CrossCounty:
            return UIColor(red: 102.0 / 255.0, green: 15.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
        case .EastMidlands:
            return UIColor(red: 255.0 / 255.0, green: 165.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        case .FirstGreatWestern:
            return UIColor(red: 10.0 / 255.0, green: 73.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)
        case .FirstHull:
            return UIColor(red: 222.0 / 255.0, green: 0.0, blue: 92.0 / 255.0, alpha: 1.0)
        case .FirstTransPennine:
            return UIColor(red: 1.0 / 255.0, green: 3.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
        case .Gatwick:
            return UIColor(red: 242.0 / 255.0, green: 0.0, blue: 23.0 / 255.0, alpha: 1.0)
        case .GrandCentral:
            return UIColor(red: 44.0 / 255.0, green: 56.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0)
        case .GreaterAnglia:
            return UIColor(red: 215.0 / 255.0, green: 4.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
        case .GreatNorthern:
            return UIColor(red: 0.0, green: 168.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        case .HeathrowConnect:
            return UIColor(red: 247.0 / 255.0, green: 143.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
        case .HeathrowExpress:
            return UIColor(red: 83.0 / 255.0, green: 46.0 / 255.0, blue: 99.0 / 255.0, alpha: 1.0)
        case .Island:
            return UIColor(red: 30.0 / 255.0, green: 144.0 / 255.0, blue: 1.0, alpha: 1.0)
        case .LondonMidland:
            return UIColor(red: 118.0 / 255.0, green: 180.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
        case .Merseyrail:
            return UIColor(red: 1.0, green: 242.0 / 255.0, blue: 0.0, alpha: 1.0)
        case .Northern:
            return UIColor(red: 139.0 / 255.0, green: 0.0, blue: 1.0, alpha: 1.0)
        case .ScotRail:
            return UIColor(red: 0.0, green: 128.0 / 255.0, blue: 0.0, alpha: 1.0)
        case .Southeastern:
            return UIColor(red: 0.0, green: 175.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
        case .Southern:
            return UIColor(red: 140.0 / 255.0, green: 198.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)
        case .SouthWest:
            return UIColor(red: 238.0 / 255.0, green: 28.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
        case .Thameslink:
            return UIColor(red: 232.0 / 255.0, green: 74.0 / 255.0, blue: 186.0 / 255.0, alpha: 1.0)
        case .Virgin:
            return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case .VirginEastCoast:
            return UIColor(red: 215.0 / 255.0, green: 14.0 / 255.0, blue: 53.0 / 255.0, alpha: 1.0)
        }
    }
    
    var description: String {
        switch self {
        case .ArrivaWales:
            return "Arriva Trains Wales"
        case .C2C:
            return "c2c"
        case .Chiltern:
            return "Chiltern Railways"
        case .CrossCounty:
            return "Cross Country"
        case .EastMidlands:
            return "East Midlands Trains"
        case .FirstGreatWestern:
            return "First Great Western"
        case .FirstHull:
            return "First Hull Trains"
        case .FirstTransPennine:
            return "First TransPennine Express"
        case .Gatwick:
            return "Gatwick Express"
        case .GrandCentral:
            return "Grand Central"
        case .GreaterAnglia:
            return "Greater Anglia"
        case .GreatNorthern:
            return "Great Northern"
        case .HeathrowConnect:
            return "Heathrow Connect"
        case .HeathrowExpress:
            return "Heathrow Express"
        case .Island:
            return "Island Line"
        case .LondonMidland:
            return "London Midland"
        case .Merseyrail:
            return "Merseyrail"
        case .Northern:
            return "Northern Rail"
        case .ScotRail:
            return "ScotRail"
        case .Southeastern:
            return "Southeastern"
        case .Southern:
            return "Southern"
        case .SouthWest:
            return "South West Trains"
        case .Thameslink:
            return "Thameslink"
        case .Virgin:
            return "Virgin Trains"
        case .VirginEastCoast:
            return "Virgin Trains East Coast"
        }
    }
}
