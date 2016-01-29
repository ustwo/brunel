//
//  DetailView.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


final class DetailView: BaseStackView {
    
    
    // MARK: - Properties
    
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let disruptionLabel = UILabel()
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        backgroundColor = UIColor.whiteColor()
        
        nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        nameLabel.textAlignment = .Center
        stackView.addArrangedSubview(nameLabel)
        
        statusLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle3)
        statusLabel.textAlignment = .Center
        stackView.addArrangedSubview(statusLabel)
        
        disruptionLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle3)
        disruptionLabel.hidden = true
        disruptionLabel.lineBreakMode = .ByWordWrapping
        disruptionLabel.numberOfLines = 0
        disruptionLabel.textAlignment = .Center
        stackView.addArrangedSubview(disruptionLabel)
        
        let bufferView = UIView()
        bufferView.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Vertical)
        bufferView.setContentHuggingPriority(UILayoutPriorityDefaultLow, forAxis: .Vertical)
        stackView.addArrangedSubview(bufferView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let stackViewMargin = Constants.Layout.HalfMargin
        contentInsets = UIEdgeInsets(top: stackViewMargin, left: stackViewMargin, bottom: stackViewMargin, right: stackViewMargin)
    }
    
    override func setupAccessibility() {
        super.setupAccessibility()
        
        nameLabel.accessibilityIdentifier = AccessibilityIdentifiers.LineDetail.NameLabel
        statusLabel.accessibilityIdentifier = AccessibilityIdentifiers.LineDetail.StatusLabel
        disruptionLabel.accessibilityIdentifier = AccessibilityIdentifiers.LineDetail.DisruptionLabel
    }
    
}
