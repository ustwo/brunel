//
//  TFLRestAPI-GET.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation


extension TFLRestAPI {
    
    func getLineStatus(_ modes: [TFLModes], completion: @escaping ([TFLLine]?, RestAPIError?) -> Void) {
        tfl(lineProvider, target: .modeStatus(modes: modes, detail: true), completion: { resultJSON, error in
            if let resultJSON = resultJSON {
                
                var lines = [TFLLine]()
                guard let jsonArray = resultJSON.array else {
                    completion(nil, .invalidJSON(localizedDescription: "Expected array."))
                    return
                }
                
                
                for jsonItem in jsonArray {
                    guard let line = TFLLine(jsonObject: jsonItem) else {
                        completion(nil, .invalidJSON(localizedDescription: "Bad JSON to initialize `TFLLine`."))
                        return
                    }
                    
                    lines.append(line)
                }
                
                completion(lines, nil)
            } else if let error = error {
                completion(nil, error)
                return
            } else {
                completion(nil, .unknownError)
                return
            }
        })
    }
    
    func getLineSearch(_ query: String, completion: @escaping ([TFLLineSearch]?, RestAPIError?) -> Void) {
        tfl(lineProvider, target: .search(query: query), completion: { resultJSON, error in
            if let resultJSON = resultJSON {
                
                var lines = [TFLLineSearch]()
                guard let jsonArray = resultJSON["searchMatches"].array else {
                    completion(nil, .invalidJSON(localizedDescription: "Expected array."))
                    return
                }
                
                
                for jsonItem in jsonArray {
                    if let line = TFLLineSearch(jsonObject: jsonItem) {
                        lines.append(line)
                    }
                }
                
                completion(lines, nil)
            } else if let error = error {
                completion(nil, error)
                return
            } else {
                completion(nil, .unknownError)
                return
            }
        })
    }
    
    func getLineStatus(_ lines: [String], completion: @escaping ([TFLLine]?, RestAPIError?) -> Void) {
        tfl(lineProvider, target: .status(lines: lines, detail: true), completion: { resultJSON, error in
            if let resultJSON = resultJSON {
                
                var lines = [TFLLine]()
                guard let jsonArray = resultJSON.array else {
                    completion(nil, .invalidJSON(localizedDescription: "Expected array."))
                    return
                }
                
                
                for jsonItem in jsonArray {
                    guard let line = TFLLine(jsonObject: jsonItem) else {
                        completion(nil, .invalidJSON(localizedDescription: "Bad JSON to initialize `TFLLine`."))
                        return
                    }
                    
                    lines.append(line)
                }
                
                completion(lines, nil)
            } else if let error = error {
                completion(nil, error)
                return
            } else {
                completion(nil, .unknownError)
                return
            }
        })
    }
    
}
