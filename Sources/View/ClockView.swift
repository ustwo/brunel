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
                updateTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateClock:"), userInfo: nil, repeats: true)
            } else {
                updateTimer?.invalidate()
            }
        }
    }
    
    private var updateTimer: NSTimer?
    
    
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
        font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle, timeStyle: .MediumStyle)
        textAlignment = .Center
        
        accessibilityIdentifier = AccessibilityIdentifiers.Clock.ClockLabel
    }
    
    
    // MARK: - Clock
    
    func updateClock(timer: NSTimer) {
        text = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle, timeStyle: .MediumStyle)
    }
    
}
