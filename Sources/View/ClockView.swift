//
//  ClockView.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


final class ClockLabel: UILabel {
    
    
    // MARK: - Properties
    
    var on: Bool = false {
        didSet {
            if on {
                updateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ClockLabel.updateClock(_:)), userInfo: nil, repeats: true)
            } else {
                updateTimer?.invalidate()
            }
        }
    }
    
    private var updateTimer: Timer?
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Setup
    
    func setup() {
        font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
        text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        textAlignment = .center
        
        accessibilityIdentifier = AccessibilityIdentifiers.Clock.ClockLabel
    }
    
    
    // MARK: - Clock
    
    func updateClock(_ timer: Timer) {
        text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
    }
    
}
