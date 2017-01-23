//
//  TFLLineServiceType.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import Foundation

import SwiftyJSON


/**
 *  Represents a type of service for a TfL line.
 */
struct TFLLineServiceType {
    
    let name: String
    let uri: String
    
    private struct JSONKeys {
        static let name = "name"
        static let uri = "uri"
    }
    
    init?(jsonObject: JSON) {
        guard let jsonName = jsonObject[JSONKeys.name].string,
            let jsonURI = jsonObject[JSONKeys.uri].string else {
                
                return nil
        }
        
        name = jsonName
        uri = jsonURI
    }
    
}
