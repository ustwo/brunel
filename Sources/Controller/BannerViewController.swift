//
//  BannerViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Container view controller that holds a child veiw (called `embeddedView` and a banner below.
final class BannerViewController: BaseViewController<BannerView> {
    
    
    // MARK: - Properties
    
    /// View to embed above the banner.
    private let embeddedView: UIView
    
    private let embeddedViewController: UIViewController
    
    
    // MARK: - Initializers
    
    init(embeddedViewController: UIViewController) {
        self.embeddedView = embeddedViewController.view
        self.embeddedViewController = embeddedViewController
        
        super.init()
        
        addChildViewController(embeddedViewController)
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        underlyingView.stackView.insertArrangedSubview(embeddedView, atIndex: 0)
        embeddedViewController.didMoveToParentViewController(self)
        
        title = embeddedViewController.title
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)]
    }
    
    override func viewWillAppear(animated: Bool) {
        underlyingView.banner.clock.on = true
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
         underlyingView.banner.clock.on = false
        
        super.viewWillDisappear(animated)
    }
    
}
