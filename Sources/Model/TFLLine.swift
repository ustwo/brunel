//
//  TFLLine.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//


import SwiftyJSON
import UIKit


/**
 *  Represents a specific transportation line in TfL's network.
 */
struct TFLLine {
    
    let color: UIColor
    let created: Date?
    let identifier: String
    let lineStatuses: [TFLLineStatus]
    let mode: TFLModes
    let modeName: String
    let modified: Date?
    let name: String
    let serviceTypes: [TFLLineServiceType]
    
    private struct JSONKeys {
        static let identifier = "id"
        static let modeName = "modeName"
        static let created = "created"
        static let modified = "modified"
        static let serviceTypes = "serviceTypes"
        static let name = "name"
        static let lineStatuses = "lineStatuses"
    }
    
    init?(jsonObject: JSON) {
        guard let jsonIdentifier = jsonObject[JSONKeys.identifier].string,
            let jsonModeName = jsonObject[JSONKeys.modeName].string,
            let jsonMode = TFLModes(rawValue: jsonModeName),
            let jsonLineStatuses = jsonObject[JSONKeys.lineStatuses].array,
            let jsonName = jsonObject[JSONKeys.name].string,
            let jsonServiceTypes = jsonObject[JSONKeys.serviceTypes].array else {
                
                return nil
        }
        
        identifier = jsonIdentifier
        mode = jsonMode
        modeName = jsonModeName
        name = jsonName
        
        created = TFLLine.dateFromJSON(jsonObject, key: JSONKeys.created)
        modified = TFLLine.dateFromJSON(jsonObject, key: JSONKeys.modified)
        
        var lineStatusesArray = [TFLLineStatus]()
        for jsonLineStatus in jsonLineStatuses {
            guard let lineStatus = TFLLineStatus(jsonObject: jsonLineStatus) else {
                print("Error. Bad JSON to initialize `TFLLineStatus`.")
                return nil
            }
            lineStatusesArray.append(lineStatus)
        }
        lineStatuses = lineStatusesArray.sorted { $0.severity > $1.severity }
        
        var serviceTypesArray = [TFLLineServiceType]()
        for jsonServiceType in jsonServiceTypes {
            guard let serviceType = TFLLineServiceType(jsonObject: jsonServiceType) else {
                print("Error. Bad JSON to initialize `TFLLineServiceType`.")
                return nil
            }
            serviceTypesArray.append(serviceType)
        }
        serviceTypes = serviceTypesArray
        
        if mode == .Underground,
            let undergroundIndex = TFLUnderground.allValues.index(where: { $0.description.uppercased() == jsonName.uppercased() }) {
                
                let undergroundLine = TFLUnderground.allValues[undergroundIndex]
                
                color = undergroundLine.color
        } else if mode == .NationalRail,
            let railIndex = TFLNationalRail.allValues.index(where: { $0.description.uppercased() == jsonName.uppercased() }) {
                
                let railLine = TFLNationalRail.allValues[railIndex]
                
                color = railLine.color
        } else {
            color = mode.color
        }
        
    }
    
    private static func dateFromJSON(_ jsonObject: JSON, key: String) -> Date? {
        guard let jsonDateString = jsonObject[key].string else {
            return nil
        }
        
        return TFLDateFormatter.sharedInstance.dateFromString(jsonDateString)
    }
    
}
