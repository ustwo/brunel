//
//  ModesBaseTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Base view controller that displays a table of `TFLMode`.
class ModesBaseTableViewController: UITableViewController {
    
    
    // MARK: - Properties
    
    var detailViewController: LineDetailViewController? = nil
    
    let modes = TFLModes.allValues
    
    private let reuseIdentifier = "Cell"
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as? UINavigationController)?.topViewController as? LineDetailViewController
        }
        
        title = Strings.Titles.Modes
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - UITableViewDatasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        let mode = itemForIndexPath(indexPath)
        
        cell.textLabel?.text = mode.description
        
        let cellColor = mode.color
        #if os(iOS)
            cell.backgroundColor = cellColor
        #endif
        cell.contentView.backgroundColor = cellColor
        
        if cellColor.isLight() {
            cell.textLabel?.textColor = UIColor.blackColor()
        } else {
            cell.textLabel?.textColor = UIColor.whiteColor()
        }
        
        cell.accessibilityIdentifier = AccessibilityIdentifiers.Modes.ModeCellPrefix + "_\(mode.description)"
        
        return cell
    }
    
    func itemForIndexPath(indexPath: NSIndexPath) -> TFLModes {
        return modes[indexPath.row]
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.textLabel?.textColor = UIColor.blackColor()
        
        return indexPath
    }
    
    override func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let item = itemForIndexPath(indexPath)
        
        if item.color.isLight() {
            cell?.textLabel?.textColor = UIColor.blackColor()
        } else {
            cell?.textLabel?.textColor = UIColor.whiteColor()
        }
        
        return indexPath
    }
    
}
