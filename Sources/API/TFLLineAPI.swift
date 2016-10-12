//
//  TFLLineAPI.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation

import Moya


/**
 TfL API endpoints for lines.
 
 - ModeStatus: Fetches the status for all transport lines of the given modes.
 - Search:     Search for transport lines based on a query.
 - Status:     Fetches the status for an array of transport lines.
 */
enum TFLLineAPI {
    case ModeStatus(modes: [TFLModes], detail: Bool)
    case Search(query: String)
    case Status(lines: [String], detail: Bool)
}


extension TFLLineAPI: TargetType {
    
    var baseURL: NSURL { return NSURL(string: "https://api.tfl.gov.uk")! }
    
    var path: String {
        switch self {
        case let .ModeStatus(modes, _):
            let result = csvFromArray(modes.map { $0.rawValue })
            return "/line/mode/\(result)/status"
        case let Search(query):
            return "/line/search/\(query)"
        case let .Status(lines, _):
            let result = csvFromArray(lines)
            return "/line/\(result)/status"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .ModeStatus, .Search, .Status:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case let .ModeStatus(_, detail):
            return ["detail" : encodeBool(detail)]
        case let .Status(_, detail):
            return ["detail" : encodeBool(detail)]
            
        case .Search:
            return nil
        }
    }
    
    var sampleData: NSData {
        let emptyStringData = "".dataUsingEncoding(NSUTF8StringEncoding)!
        return emptyStringData
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
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
