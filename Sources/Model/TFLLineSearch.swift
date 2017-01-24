//
//  TFLLineSearch.swift
//  Brunel
//
//  Created by Aaron McTavish on 21/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit

import SwiftyJSON


/**
 *  A condensed version of `TFLLine` that is used as the return type from a search endpoint.
 */
struct TFLLineSearch {
    
    let color: UIColor
    let identifier: String
    let mode: TFLModes
    let modeName: String
    let name: String
    
    private struct JSONKeys {
        static let identifier = "lineId"
        static let modeName = "mode"
        static let name = "lineName"
    }
    
    init?(jsonObject: JSON) {
        guard let jsonIdentifier = jsonObject[JSONKeys.identifier].string,
            let jsonModeName = jsonObject[JSONKeys.modeName].string,
            let jsonMode = TFLModes(rawValue: jsonModeName),
            let jsonName = jsonObject[JSONKeys.name].string else {
                
                return nil
        }
        
        identifier = jsonIdentifier
        mode = jsonMode
        modeName = jsonModeName
        name = jsonName
        
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
    
}
