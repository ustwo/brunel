//
//  LineWikiView.swift
//  Brunel
//
//  Created by Aaron McTavish on 02/02/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit


final class LineWikiView: BaseStackView {
    
    
    // MARK: - Properties
    
    let wikiLabel = UILabel()
    
    let backButton = UIButton(type: .system)
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        backgroundColor = UIColor.white
        
        wikiLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        wikiLabel.lineBreakMode = .byWordWrapping
        wikiLabel.numberOfLines = 0
        stackView.addArrangedSubview(wikiLabel)
        
        backButton.setTitle(Strings.Buttons.Back, for: UIControlState())
        stackView.addArrangedSubview(backButton)
    }
    
    
    // MARK: - Layout
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let stackViewMargin = Constants.Layout.HalfMargin
        contentInsets = UIEdgeInsets(top: stackViewMargin, left: stackViewMargin, bottom: stackViewMargin, right: stackViewMargin)
    }
    
}
