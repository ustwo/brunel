//
//  Moya-ErrorDescriptions.swift
//  Brunel
//
//  Created by Aaron McTavish on 26/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation

import Moya


extension MoyaError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .imageMapping:
            return "Image Mapping Error"
        case .jsonMapping:
            return "JSON Mapping Error"
        case .requestMapping:
            return "Request Error"
        case .statusCode:
            return "Status Code Error"
        case .stringMapping:
            return "String Mapping Error"
        case .underlying:
            let nsError = self as NSError
            return nsError.localizedDescription
        }
    }
    
}
