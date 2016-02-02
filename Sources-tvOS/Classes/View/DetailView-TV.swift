//
//  DetailView-TV.swift
//  Brunel
//
//  Created by Aaron McTavish on 01/02/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


extension DetailView {
    
    func insertAboutButton() -> UIButton? {
        // Make sure we only add the about button once!
        guard stackView.arrangedSubviews.filter({ $0 is UIButton }).isEmpty else {
            return nil
        }
        
        let aboutButton = UIButton(type: .System)
        aboutButton.setTitle(Strings.Buttons.About, forState: .Normal)
        stackView.addArrangedSubview(aboutButton)
        
        return aboutButton
    }
    
}
