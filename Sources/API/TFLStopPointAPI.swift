//
//  TFLStopPointAPI.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
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
        case .stopPointList:
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
    
    private func csvFromArray(_ value: [String]) -> String {
        var result = value.reduce("", { $0 + "," + $1 })
        result = String(result.characters.dropFirst())
        
        return result
    }
    
    private func encodeBool(_ value: Bool) -> String {
        return value ? "True" : "False"
    }
    
}
