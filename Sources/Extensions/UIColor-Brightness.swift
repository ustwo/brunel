//
//  UIColor-Brightness.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


extension UIColor {
    
    /**
    Determines whether or not the color is light (as opposed to dark).
    
    - seealso: [http://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright](http://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright)
    - returns: Whether or not the color is light.
    */
    func isLight() -> Bool {
        let components = CGColorGetComponents(self.CGColor)
        let numerator = (components[0] * 299) + (components[1] * 587) + (components[2] * 114)
        let brightness = numerator / 1000
        
        if brightness < 0.5 {
            return false
        } else {
            return true
        }
    }
    
}
