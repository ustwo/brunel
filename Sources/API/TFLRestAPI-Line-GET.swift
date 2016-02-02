//
//  TFLRestAPI-GET.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation


extension TFLRestAPI {
    
    func getLineStatus(modes: [TFLModes], completion: ([TFLLine]?, RestAPIError?) -> Void) {
        tfl(lineProvider, target: .ModeStatus(modes: modes, detail: true), completion: { resultJSON, error in
            if let resultJSON = resultJSON {
                
                var lines = [TFLLine]()
                guard let jsonArray = resultJSON.array else {
                    completion(nil, .InvalidJSON(localizedDescription: "Expected array."))
                    return
                }
                
                
                for jsonItem in jsonArray {
                    guard let line = TFLLine(jsonObject: jsonItem) else {
                        completion(nil, .InvalidJSON(localizedDescription: "Bad JSON to initialize `TFLLine`."))
                        return
                    }
                    
                    lines.append(line)
                }
                
                completion(lines, nil)
            } else if let error = error {
                completion(nil, error)
                return
            } else {
                completion(nil, .UnknownError)
                return
            }
        })
    }
    
    func getLineSearch(query: String, completion: ([TFLLineSearch]?, RestAPIError?) -> Void) {
        tfl(lineProvider, target: .Search(query: query), completion: { resultJSON, error in
            if let resultJSON = resultJSON {
                
                var lines = [TFLLineSearch]()
                guard let jsonArray = resultJSON["searchMatches"].array else {
                    completion(nil, .InvalidJSON(localizedDescription: "Expected array."))
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
                completion(nil, .UnknownError)
                return
            }
        })
    }
    
    func getLineStatus(lines: [String], completion: ([TFLLine]?, RestAPIError?) -> Void) {
        tfl(lineProvider, target: .Status(lines: lines, detail: true), completion: { resultJSON, error in
            if let resultJSON = resultJSON {
                
                var lines = [TFLLine]()
                guard let jsonArray = resultJSON.array else {
                    completion(nil, .InvalidJSON(localizedDescription: "Expected array."))
                    return
                }
                
                
                for jsonItem in jsonArray {
                    guard let line = TFLLine(jsonObject: jsonItem) else {
                        completion(nil, .InvalidJSON(localizedDescription: "Bad JSON to initialize `TFLLine`."))
                        return
                    }
                    
                    lines.append(line)
                }
                
                completion(lines, nil)
            } else if let error = error {
                completion(nil, error)
                return
            } else {
                completion(nil, .UnknownError)
                return
            }
        })
    }
    
}
