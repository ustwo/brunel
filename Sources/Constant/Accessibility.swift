//
//  Accessibility.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation


/**
 *  Accessibility identifiers used within the app.
 */
struct AccessibilityIdentifiers {
    
    struct Buttons {
        static let SearchButton         = "SEARCH_BUTTON"
    }
    
    struct Clock {
        static let ClockLabel           = "CLOCK_LABEL"
    }
    
    struct Lines {
        static let LineCellPrefix       = "LINE_CELL"
        static let LineDetailCellPrefix = "LINE_DETAIL_CELL"
        static let SearchBar            = "LINE_SEARCHBAR"
    }
    
    struct LineDetail {
        static let NameLabel            = "NAME_LABEL"
        static let StatusLabel          = "STATUS_LABEL"
        static let DisruptionLabel      = "DISRUPTION_LABEL"
    }
    
    struct LineDetailCell {
        static let NameLabel            = "NAME_LABEL"
        static let StatusLabel          = "STATUS_LABEL"
    }
    
    struct Modes {
        static let ModeCellPrefix       = "MODE_CELL"
    }
    
}
