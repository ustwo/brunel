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
    case modeStatus(modes: [TFLModes], detail: Bool)
    case search(query: String)
    case status(lines: [String], detail: Bool)
}


extension TFLLineAPI: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.tfl.gov.uk")! }
    
    var path: String {
        switch self {
        case let .modeStatus(modes, _):
            let result = csvFromArray(modes.map { $0.rawValue })
            return "/line/mode/\(result)/status"
        case let .search(query):
            return "/line/search/\(query)"
        case let .status(lines, _):
            let result = csvFromArray(lines)
            return "/line/\(result)/status"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .modeStatus, .search, .status:
            return .get
        }
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .modeStatus(_, detail):
            return ["detail": encodeBool(detail)]
        case let .status(_, detail):
            return ["detail": encodeBool(detail)]
        case .search:
            return nil
        }
    }
    
    var sampleData: Data {
        let emptyStringData = "".data(using: String.Encoding.utf8)!
        return emptyStringData
    }
    
    var task: Task {
        return .request
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
