//
//  Moya-ErrorDescriptions.swift
//  Brunel
//
//  Created by Aaron McTavish on 26/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation

import Moya


extension Moya.Error: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .Data:
            return "Data Error"
        case .ImageMapping:
            return "Image Mapping Error"
        case .JSONMapping:
            return "JSON Mapping Error"
        case .StatusCode:
            return "Status Code Error"
        case .StringMapping:
            return "String Mapping Error"
        case .Underlying:
            let nsError = self as NSError
            return nsError.localizedDescription
        }
    }
    
}
