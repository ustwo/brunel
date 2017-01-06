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
    
    var contentInsets: UIEdgeInsets = UIEdgeInsets.zero {
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
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.Layout.HalfMargin
        
        addSubview(stackView)
    }
    
    
    // MARK: - Layout
    
    override func setupConstraints() {
        super.setupConstraints()
        
        // Turn off autoresizing mask
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        let aTopConstraint = NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let aLeftConstraint = NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0.0)
        let aBottomConstraint = NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let aRightConstraint = NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0.0)
        
        addConstraints([aTopConstraint, aLeftConstraint, aBottomConstraint, aRightConstraint])
        
        topConstraint = aTopConstraint
        leftConstraint = aLeftConstraint
        bottomConstraint = aBottomConstraint
        rightConstraint = aRightConstraint
    }
    
}
