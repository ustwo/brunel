//
//  LinesBaseTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Base view controller that displays a table of `TFLLine`.
class LinesBaseTableViewController: SearchTableViewController<TFLLine> {
    
    
    // MARK: - Properties
    
    var modes: [TFLModes]?
    
    
    // MARK: - Initializers
    
    init(modes: [TFLModes]?) {
        self.modes = modes
        
        super.init(cellType: UITableViewCell.self)
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.Titles.Lines
        
        searchController.searchBar.placeholder = Strings.Placeholders.SearchLines
        searchController.searchBar.accessibilityIdentifier = AccessibilityIdentifiers.Lines.SearchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController?.collapsed ?? false
        
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - UITableViewDatasource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return modes?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mode = modes?[section] else { return 0 }
        
        let array: [TFLLine]
        if tableView == self.tableView {
            array = items
        } else {
            array = resultsTableController?.searchArray ?? items
        }
        
        return array.filter { $0.mode == mode }.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return modes?[section].description
    }
    
    override func itemForIndexPath(tableView: UITableView, indexPath: NSIndexPath) -> TFLLine? {
        guard let mode = modes?[indexPath.section] else { return nil }
        
        let array: [TFLLine]
        if tableView == self.tableView {
            array = items
        } else {
            array = resultsTableController?.searchArray ?? items
        }
        
        return array.filter { $0.mode == mode }[indexPath.row]
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.textLabel?.textColor = UIColor.blackColor()
        
        return indexPath
    }
    
    override func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        guard let line = itemForIndexPath(tableView, indexPath: indexPath) else { return indexPath }
        
        if line.color.isLight() {
            cell?.textLabel?.textColor = UIColor.blackColor()
        } else {
            cell?.textLabel?.textColor = UIColor.whiteColor()
        }
        
        return indexPath
    }
    
}
