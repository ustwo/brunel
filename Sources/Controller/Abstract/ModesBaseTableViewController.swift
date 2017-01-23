//
//  ModesBaseTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit


/// Base view controller that displays a table of `TFLMode`.
class ModesBaseTableViewController: UITableViewController {
    
    
    // MARK: - Properties
    
    var detailViewController: LineDetailViewController?
    
    let modes = TFLModes.allValues
    
    private let reuseIdentifier = "Cell"
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as? UINavigationController)?.topViewController as? LineDetailViewController
        }
        
        title = Strings.Titles.Modes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - UITableViewDatasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let mode = itemForIndexPath(indexPath)
        
        cell.textLabel?.text = mode.description
        
        let cellColor = mode.color
        #if os(iOS)
            cell.backgroundColor = cellColor
        #endif
        cell.contentView.backgroundColor = cellColor
        
        if cellColor.isLight() {
            cell.textLabel?.textColor = UIColor.black
        } else {
            cell.textLabel?.textColor = UIColor.white
        }
        
        cell.accessibilityIdentifier = AccessibilityIdentifiers.Modes.ModeCellPrefix + "_\(mode.description)"
        
        return cell
    }
    
    func itemForIndexPath(_ indexPath: IndexPath) -> TFLModes {
        return modes[indexPath.row]
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.textLabel?.textColor = UIColor.black
        
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        let item = itemForIndexPath(indexPath)
        
        if item.color.isLight() {
            cell?.textLabel?.textColor = UIColor.black
        } else {
            cell?.textLabel?.textColor = UIColor.white
        }
        
        return indexPath
    }
    
}
