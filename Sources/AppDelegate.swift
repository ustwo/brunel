//
//  AppDelegate.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

import SVProgressHUD


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    // MARK: - Properties

    var window: UIWindow?

    
    // MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Settings.registerSettings()
        
        return true
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let viewController = UISplitViewController()
        
        let rootController = ToolsTableViewController()
        let detailController = BannerViewController(embeddedViewController: DashboardTableViewController(modes: [TFLModes.Underground]))
        detailController.navigationItem.leftBarButtonItem = viewController.displayModeButtonItem
        
        #if os(iOS)
            detailController.navigationItem.leftItemsSupplementBackButton = true
        #else
            viewController.displayModeButtonItem.tintColor = UIColor.black
        #endif
        
        let rootNavigationController = UINavigationController(rootViewController: rootController)
        let detailNavigationController = UINavigationController(rootViewController: detailController)
        
        setupTheme()
        
        viewController.viewControllers = [rootNavigationController, detailNavigationController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }

    
    // MARK: - Theme
    
    /**
    Sets up the default appearance for views.
    */
    fileprivate func setupTheme() {
        SVProgressHUD.setDefaultStyle(.dark)
        
        UINavigationBar.appearance().barTintColor = Constants.Colors.BlueColor
        UINavigationBar.appearance().isOpaque = true
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
    }
    
}
