//
//  TFLLineDisruption.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation

import SwiftyJSON


/**
 *  Represents a disruption on a TfL line.
 */
struct TFLLineDisruption {
    
    let additionalInfo: String?
    let category: String
    let categoryDescription: String
    let closureText: String?
    let created: Date?
    
    fileprivate struct JSONKeys {
        static let additionalInfo = "additionalInfo"
        static let category = "category"
        static let categoryDescription = "categoryDescription"
        static let closureText = "closureText"
        static let created = "created"
    }
    
    init?(jsonObject: JSON) {
        guard let jsonCategory = jsonObject[JSONKeys.category].string,
            let jsonCategoryDescription = jsonObject[JSONKeys.categoryDescription].string else {
                
                return nil
        }
        
        additionalInfo = jsonObject[JSONKeys.additionalInfo].string
        category = jsonCategory
        categoryDescription = jsonCategoryDescription
        closureText = jsonObject[JSONKeys.closureText].string
        
        if let jsonCreatedString = jsonObject[JSONKeys.created].string,
            let jsonCreated = TFLDateFormatter.sharedInstance.dateFromString(jsonCreatedString) {
                created = jsonCreated
        } else {
            created = nil
        }
    }
    
}
