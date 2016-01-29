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
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        Settings.registerSettings()
        
        return true
    }
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let viewController = UISplitViewController()
        
        let rootController = ToolsTableViewController()
        let detailController = BannerViewController(embeddedViewController: DashboardTableViewController(modes: [TFLModes.Underground]))
        detailController.navigationItem.leftBarButtonItem = viewController.displayModeButtonItem()
        
        #if os(iOS)
            detailController.navigationItem.leftItemsSupplementBackButton = true
        #else
            viewController.displayModeButtonItem().tintColor = UIColor.blackColor()
        #endif
        
        let rootNavigationController = UINavigationController(rootViewController: rootController)
        let detailNavigationController = UINavigationController(rootViewController: detailController)
        
        setupTheme()
        
        viewController.viewControllers = [rootNavigationController, detailNavigationController]
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }

    
    // MARK: - Theme
    
    /**
    Sets up the default appearance for views.
    */
    private func setupTheme() {
        SVProgressHUD.setDefaultStyle(.Dark)
        
        UINavigationBar.appearance().barTintColor = Constants.Colors.BlueColor
        UINavigationBar.appearance().opaque = true
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
    }
    
}
