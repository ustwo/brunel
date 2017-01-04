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
        contentView.backgroundColor = UIColor.white
        
        statusSection.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .vertical)
        statusSection.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
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
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[statusSection]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        // Horizontal Constraints
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[statusSection]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
    }
    
}


final class LineDetailStatusSectionView: BaseView {

    
    // MARK: - Properties
    
    let lineLabel = LabelView()
    let statusLabel = LabelView()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        backgroundColor = UIColor.white
        
        lineLabel.textLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        addSubview(lineLabel)
        
        statusLabel.textLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
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
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[statusLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        // Horizontal Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineLabel][statusLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        addConstraint(NSLayoutConstraint(item: statusLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0.0))
    }
    
    
    // MARK: - Accessibility
    
    override func setupAccessibility() {
        super.setupAccessibility()
        
        lineLabel.textLabel.accessibilityIdentifier = AccessibilityIdentifiers.LineDetailCell.NameLabel
        statusLabel.textLabel.accessibilityIdentifier = AccessibilityIdentifiers.LineDetailCell.StatusLabel
    }
    
}
