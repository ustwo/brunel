//
//  WikipediaAPI.swift
//  Brunel
//
//  Created by Aaron McTavish on 29/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation

import Moya


enum WikipediaAPI {
    case queryTitle(title: String)
}


extension WikipediaAPI: TargetType {
    
    var baseURL: URL { return URL(string: "https://en.wikipedia.org/w/api.php")! }
    
    var path: String {
        switch self {
        case .queryTitle:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .queryTitle:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case let .queryTitle(title):
            return ["action" : "query" as AnyObject,
                "prop" : "extracts" as AnyObject,
                "exintro" : "" as AnyObject,
                "explaintext" : "" as AnyObject,
                "titles" : title as AnyObject]
        }
    }
    
    var sampleData: Data {
        let emptyStringData = "".data(using: String.Encoding.utf8)!
        return emptyStringData
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
    
}
