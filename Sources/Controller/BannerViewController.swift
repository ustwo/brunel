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
    fileprivate let embeddedView: UIView
    
    fileprivate let embeddedViewController: UIViewController
    
    
    // MARK: - Initializers
    
    init(embeddedViewController: UIViewController) {
        self.embeddedView = embeddedViewController.view
        self.embeddedViewController = embeddedViewController
        
        super.init()
        
        addChildViewController(embeddedViewController)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        underlyingView.stackView.insertArrangedSubview(embeddedView, at: 0)
        embeddedViewController.didMove(toParentViewController: self)
        
        title = embeddedViewController.title
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        underlyingView.banner.clock.on = true
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         underlyingView.banner.clock.on = false
        
        super.viewWillDisappear(animated)
    }
    
}
