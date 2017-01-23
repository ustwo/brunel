//
//  DetailView.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
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
        
        backgroundColor = UIColor.white
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
        nameLabel.textAlignment = .center
        stackView.addArrangedSubview(nameLabel)
        
        statusLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3)
        statusLabel.textAlignment = .center
        stackView.addArrangedSubview(statusLabel)
        
        disruptionLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3)
        disruptionLabel.isHidden = true
        disruptionLabel.lineBreakMode = .byWordWrapping
        disruptionLabel.numberOfLines = 0
        disruptionLabel.textAlignment = .center
        stackView.addArrangedSubview(disruptionLabel)
        
        let bufferView = UIView()
        bufferView.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .vertical)
        bufferView.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .vertical)
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
