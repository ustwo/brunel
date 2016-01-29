//
//  BaseView.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

/**
 BaseView acts as a common base for all custom views
 */
@objc public class BaseView: UIView {
    
    public private(set) var isSetup: Bool = false
    
    
    // MARK: - Initialisers
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setup()
        self.setupAccessibility()
        self.setupConstraints()
        
        self.isSetup = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override public  func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Since awakeFromNib can be called multiple times we check to see if setup routines have been called already for safety
        
        if !self.isSetup {
            
            self.setup()
            self.setupAccessibility()
            self.setupConstraints()
            
            self.isSetup = true
        }
    }
    
    
    // MARK: - Setup
    
    /**
    Abstract setup method for initial setup of the view and all its subviews.
    
    Override this function to initialize subviews, set default values, etc.
    */
    public func setup() {
        // Abstract method.
    }
    
    
    // MARK: - Accessibility
    
    /**
    Setup for the view's accessibility
    
    Override this function to add accessibility to their subviews (e.g. `accesibilityIdentifier`, `accessibilityLabel`, `accessibilityHint`, etc.).
    
    - Note: It is best to use this for static identifiers that will not change at runtime. For dynamically generated identifiers or identifiers that will change over time, we recommend doing this in the view controller or view model as appropriate.
    */
    public func setupAccessibility() {
        // Abstract method.
    }
    
    
    // MARK: - Constraints
    
    /**
    Abstract setup method for the view's constraints.
    
    Override this function to add layout constraints for all the subviews.
    */
    public func setupConstraints() {
        // Abstract method.
    }
}
