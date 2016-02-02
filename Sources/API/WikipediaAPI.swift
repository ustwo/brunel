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
    case QueryTitle(title: String)
}


extension WikipediaAPI: TargetType {
    
    var baseURL: NSURL { return NSURL(string: "https://en.wikipedia.org/w/api.php")! }
    
    var path: String {
        switch self {
        case .QueryTitle:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .QueryTitle:
            return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case let .QueryTitle(title):
            return ["action" : "query",
                "prop" : "extracts",
                "exintro" : "",
                "explaintext" : "",
                "titles" : title]
        }
    }
    
    var sampleData: NSData {
        let emptyStringData = "".dataUsingEncoding(NSUTF8StringEncoding)!
        return emptyStringData
    }
    
}
