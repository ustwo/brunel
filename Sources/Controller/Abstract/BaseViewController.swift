//
//  BaseViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Generic base view controller that automatically loads the underlying `BaseView` of type `T`.
public class BaseViewController<T : UIView>: UIViewController {
    
    
    // MARK: - Properties
    
    public var underlyingView: T {
        if let myView = view as? T {
            return myView
        }
        
        let newView = T()
        view = newView
        return newView
    }
    
    
    // MARK: - Initializers
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // MARK: - View Lifecycle
    
    public override func loadView() {
        view = T()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupAccessibility()
    }
    
    
    // MARK: - Setup
    
    // Abstract method. Subclasses should override this method to setup their view.
    public func setupView() {
        
    }
    
    // Abstract method. Subclasses should override this method to add accessibility.
    public func setupAccessibility() {
        
    }
    
}
