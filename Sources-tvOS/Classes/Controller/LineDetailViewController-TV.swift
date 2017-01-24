//
//  LineDetailViewController-TV.swift
//  Brunel
//
//  Created by Aaron McTavish on 01/02/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit


extension LineDetailViewController {
    
    
    // MARK: - Setup
    
    func setupTV() {
        guard let _ = lineWikipediaDetail(),
            let aboutButton = underlyingView.insertAboutButton() else {
                return
        }
        
        aboutButton.addTarget(self, action: #selector(LineDetailViewController.aboutButtonPressed(_:)), for: .primaryActionTriggered)
    }
    
    
    // MARK: - Convenience
    
    func lineWikipediaDetail() -> WikipediaSearchable? {
        guard let line = detailItem else {
            return nil
        }
        
        let lineWikiDetail: WikipediaSearchable
        switch line.mode {
        case .Underground:
            guard let undergroundIndex = TFLUnderground.allValues.index(where: { $0.description.uppercased() == line.name.uppercased() }) else {
                return nil
            }
            
            lineWikiDetail = TFLUnderground.allValues[undergroundIndex]
        default:
            return nil
        }
        
        return lineWikiDetail
    }
    
}
