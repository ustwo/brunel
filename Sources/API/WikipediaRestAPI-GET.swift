//
//  WikipediaRestAPI-GET.swift
//  Brunel
//
//  Created by Aaron McTavish on 01/02/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation


extension WikipediaRestAPI {
    
    func getQueryTitle(_ title: String, completion: @escaping (String?, RestAPIError?) -> Void) {
        wikipedia(provider, target: .QueryTitle(title: title), completion: { resultJSON, error in
            if let resultJSON = resultJSON {
                guard let pagesDictionary = resultJSON["query"]["pages"].dictionary else {
                    completion(nil, .InvalidJSON(localizedDescription: "Expected `pages` dictionary."))
                    return
                }
                
                let firstKey = Array(pagesDictionary.keys)[0]
                
                guard let extract = pagesDictionary[firstKey]?["extract"].string else {
                    completion(nil, .InvalidJSON(localizedDescription: "Expected `extract`."))
                    return
                }
                
                completion(extract, nil)
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
