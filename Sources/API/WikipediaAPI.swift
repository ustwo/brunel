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
        case let .queryTitle(title):
            return ["action": "query",
                "prop": "extracts",
                "exintro": "",
                "explaintext": "",
                "titles": title]
        }
    }
    
    var sampleData: Data {
        let emptyStringData = "".data(using: String.Encoding.utf8)!
        return emptyStringData
    }
    
    var task: Task {
        return .request
    }
    
}
