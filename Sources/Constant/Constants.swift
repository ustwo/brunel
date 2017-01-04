//
//  Constants.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/**
 *  Constants used within the app.
 */
struct Constants {
    
    struct Animation {
        static let Scrolling    = 4.0
    }
    
    struct Colors {
        static let BlueColor = UIColor(red: 26.0 / 255.0, green: 90.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
    }
    
    struct Layout {
        static let DefaultMargin: CGFloat   = 20.0
        static let HalfMargin: CGFloat      = DefaultMargin / 2.0
        
        static let Metrics = ["DefaultMargin": DefaultMargin, "HalfMargin": HalfMargin]
    }
    
    struct Settings {
        static let MaxRecentLines   = 5
    }
    
    struct Sizes {
        static let EstimatedCellHeight: CGFloat = 44.0
    }
    
}
