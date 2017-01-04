//
//  ModesToDashboardTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Table of modes of transportation that, when selected, displays a dashboard overview of all lines for the mode.
final class ModesToDashboardTableViewController: ModesBaseTableViewController {
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemForIndexPath(indexPath)
        
        let controller = BannerViewController(embeddedViewController: DashboardTableViewController(modes: [item]))
        let navigationViewController = UINavigationController(rootViewController: controller)
        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
        
        #if os(iOS)
            // While this is already set via `UINavigationBar.appearance()` in the `AppDelegate.setupTheme()`, there is currenty a bug in UIKit on iOS that causes the transparency not to be set in time from the appearance proxy. Radar: 24362789
            navigationViewController.navigationBar.isTranslucent = false
            
            controller.navigationItem.leftItemsSupplementBackButton = true
        #endif
        
        showDetailViewController(navigationViewController, sender: nil)
    }
    
}
