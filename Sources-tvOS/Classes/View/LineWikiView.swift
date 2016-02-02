//
//  LineWikiView.swift
//  Brunel
//
//  Created by Aaron McTavish on 02/02/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


final class LineWikiView: BaseStackView {
    
    
    // MARK: - Properties
    
    let wikiLabel = UILabel()
    
    let backButton = UIButton(type: .System)
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        backgroundColor = UIColor.whiteColor()
        
        wikiLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        wikiLabel.lineBreakMode = .ByWordWrapping
        wikiLabel.numberOfLines = 0
        stackView.addArrangedSubview(wikiLabel)
        
        backButton.setTitle(Strings.Buttons.Back, forState: .Normal)
        stackView.addArrangedSubview(backButton)
    }
    
    
    // MARK: - Layout
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let stackViewMargin = Constants.Layout.HalfMargin
        contentInsets = UIEdgeInsets(top: stackViewMargin, left: stackViewMargin, bottom: stackViewMargin, right: stackViewMargin)
    }
    
}
