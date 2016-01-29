//
//  BaseStackView.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

class BaseStackView: BaseView {
    
    // MARK: - Properties
    
    let stackView = UIStackView()
    
    var contentInsets: UIEdgeInsets = UIEdgeInsetsZero {
        didSet {
            topConstraint?.constant = contentInsets.top
            leftConstraint?.constant = contentInsets.left
            bottomConstraint?.constant = -contentInsets.bottom
            rightConstraint?.constant = -contentInsets.right
        }
    }
    
    private var topConstraint: NSLayoutConstraint?
    private var leftConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var rightConstraint: NSLayoutConstraint?
    
    
    // MARK: - Setup
    
    override func setup() {
        super.setup()
        
        stackView.axis = .Vertical
        stackView.distribution = .EqualSpacing
        stackView.spacing = Constants.Layout.HalfMargin
        
        addSubview(stackView)
    }
    
    
    // MARK: - Layout
    
    override func setupConstraints() {
        super.setupConstraints()
        
        // Turn off autoresizing mask
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        let aTopConstraint = NSLayoutConstraint(item: stackView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let aLeftConstraint = NSLayoutConstraint(item: stackView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let aBottomConstraint = NSLayoutConstraint(item: stackView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let aRightConstraint = NSLayoutConstraint(item: stackView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0.0)
        
        addConstraints([aTopConstraint, aLeftConstraint, aBottomConstraint, aRightConstraint])
        
        topConstraint = aTopConstraint
        leftConstraint = aLeftConstraint
        bottomConstraint = aBottomConstraint
        rightConstraint = aRightConstraint
    }
    
}
