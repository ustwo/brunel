//
//  TFLStopPointAPI.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation

import Moya


/**
 TfL API endpoints for stop points (e.g. stations).
 
 - StopPointList: Lists all stop points for an array of transport modes.
 */
enum TFLStopPointAPI {
    case StopPointList(modes: [TFLModes])
}


extension TFLStopPointAPI: TargetType {
    
    var baseURL: NSURL { return NSURL(string: "https://api.tfl.gov.uk")! }
    
    var path: String {
        switch self {
        case let .StopPointList(modes):
            let result = csvFromArray(modes.map { $0.rawValue })
            return "/stoppoint/mode/\(result)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .StopPointList:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .StopPointList:
            return nil
        }
    }
    
    var sampleData: NSData {
        let emptyStringData = "".dataUsingEncoding(NSUTF8StringEncoding)!
        return emptyStringData
    }
    
    // MARK: - Convenience
    
    private func csvFromArray(value: [String]) -> String {
        var result = value.reduce("", combine: { $0 + "," + $1})
        result = String(result.characters.dropFirst())
        
        return result
    }
    
    private func encodeBool(value: Bool) -> String {
        return value ? "True" : "False"
    }
    
}
