//
//  TFLLineStatus.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation

import SwiftyJSON


/**
 *  Represents a current (or future) status of a TfL line (e.g. Good Service, Minor Delay, etc.).
 */
struct TFLLineStatus {
    
    let created: NSDate?
    let disruption: TFLLineDisruption?
    let identifier: Int
    let severity: Int
    let severityDescription: String
    
    private struct JSONKeys {
        static let created = "created"
        static let disruption = "disruption"
        static let identifier = "id"
        static let severity = "statusSeverity"
        static let severityDescription = "statusSeverityDescription"
    }
    
    init?(jsonObject: JSON) {
        guard let jsonIdentifier = jsonObject[JSONKeys.identifier].int,
            jsonSeverity = jsonObject[JSONKeys.severity].int,
            jsonSeverityDescription = jsonObject[JSONKeys.severityDescription].string else {
                
            return nil
        }
        
        disruption = TFLLineDisruption(jsonObject: jsonObject[JSONKeys.disruption])
        identifier = jsonIdentifier
        severity = jsonSeverity
        severityDescription = jsonSeverityDescription
        
        if let jsonCreatedString = jsonObject[JSONKeys.created].string,
            jsonCreated = TFLDateFormatter.sharedInstance.dateFromString(jsonCreatedString) {
                created = jsonCreated
        } else {
            created = nil
        }
    }
    
}
