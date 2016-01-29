//
//  LinesPickerBaseTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Base view controller to allow for selecting a `TFLLine` to display in the line status details.
class LinesPickerBaseTableViewController: LinesBaseTableViewController {
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let line = itemForIndexPath(tableView, indexPath: indexPath)
        let controller = LineDetailViewController()
        
        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        #if os(iOS)
            controller.navigationItem.leftItemsSupplementBackButton = true
        #endif
        
        let navigationViewController = UINavigationController(rootViewController: controller)
        
        controller.detailItem = line
        
        #if os(tvOS)
            if tableView != self.tableView {
                dismissViewControllerAnimated(true, completion: nil)
            }
        #endif
        
        showDetailViewController(navigationViewController, sender: nil)
    }
    
}
