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
    case stopPointList(modes: [TFLModes])
}


extension TFLStopPointAPI: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.tfl.gov.uk")! }
    
    var path: String {
        switch self {
        case let .stopPointList(modes):
            let result = csvFromArray(modes.map { $0.rawValue })
            return "/stoppoint/mode/\(result)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .stopPointList:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .stopPointList:
            return nil
        }
    }
    
    var sampleData: Data {
        let emptyStringData = "".data(using: String.Encoding.utf8)!
        return emptyStringData
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
    
    // MARK: - Convenience
    
    fileprivate func csvFromArray(_ value: [String]) -> String {
        var result = value.reduce("", { $0 + "," + $1})
        result = String(result.characters.dropFirst())
        
        return result
    }
    
    fileprivate func encodeBool(_ value: Bool) -> String {
        return value ? "True" : "False"
    }
    
}
