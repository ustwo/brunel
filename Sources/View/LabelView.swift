//
//  LabelView.swift
//  Brunel
//
//  Created by Aaron McTavish on 22/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


final class LabelView: BaseView {
    
    
    // MARK: - Properties
    
    let textLabel = UILabel()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        textLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        addSubview(textLabel)
    }
    
    
    // MARK: - Layout
    
    override func setupConstraints() {
        super.setupConstraints()
        
        // Turn off autoresizing mask
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // View Dictionary
        let views = ["textLabel" : textLabel]
        let metrics = Constants.Layout.Metrics
        
        // Vertical Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-HalfMargin-[textLabel]-HalfMargin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        // Horizontal Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-HalfMargin-[textLabel]-HalfMargin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
    }
    
    
}
