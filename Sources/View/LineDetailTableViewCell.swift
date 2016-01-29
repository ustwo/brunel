//
//  LineDetailTableViewCell.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


final class LineDetailTableViewCell: UITableViewCell {
    
    
    // MARK: - Properties
    
    let statusSection = LineDetailStatusSectionView()
    
    
    // MARK: - Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Setup
    
    func setup() {
        contentView.backgroundColor = UIColor.whiteColor()
        
        statusSection.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, forAxis: .Vertical)
        statusSection.setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Vertical)
        contentView.addSubview(statusSection)
    }
    
    
    // MARK: - Layout
    
    func setupConstraints() {
        // Turn off autoresizing mask
        statusSection.translatesAutoresizingMaskIntoConstraints = false
        
        // View Dictionary
        let views = ["statusSection" : statusSection]
        let metrics = Constants.Layout.Metrics
        
        // Vertical Constraints
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[statusSection]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        // Horizontal Constraints
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[statusSection]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
    }
    
}


final class LineDetailStatusSectionView: BaseView {

    
    // MARK: - Properties
    
    let lineLabel = LabelView()
    let statusLabel = LabelView()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        backgroundColor = UIColor.whiteColor()
        
        lineLabel.textLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        addSubview(lineLabel)
        
        statusLabel.textLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        addSubview(statusLabel)
    }
    
    
    // MARK: - Layout
    
    override func setupConstraints() {
        super.setupConstraints()
        
        // Turn off autoresizing mask
        lineLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // View Dictionary
        let views = ["lineLabel" : lineLabel, "statusLabel" : statusLabel]
        var metrics = Constants.Layout.Metrics
        metrics["statusLabelWidth"] = 100.0
        
        // Vertical Constraints
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[lineLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[statusLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        // Horizontal Constraints
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[lineLabel][statusLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraint(NSLayoutConstraint(item: statusLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.5, constant: 0.0))
    }
    
    
    // MARK: - Accessibility
    
    override func setupAccessibility() {
        super.setupAccessibility()
        
        lineLabel.textLabel.accessibilityIdentifier = AccessibilityIdentifiers.LineDetailCell.NameLabel
        statusLabel.textLabel.accessibilityIdentifier = AccessibilityIdentifiers.LineDetailCell.StatusLabel
    }
    
}
