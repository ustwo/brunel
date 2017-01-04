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
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController?.isCollapsed ?? false
        
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - UITableViewDatasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return modes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mode = modes?[section] else { return 0 }
        
        let array: [TFLLine]
        if tableView == self.tableView {
            array = items
        } else {
            array = resultsTableController?.searchArray ?? items
        }
        
        return array.filter { $0.mode == mode }.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return modes?[section].description
    }
    
    override func itemForIndexPath(_ tableView: UITableView, indexPath: IndexPath) -> TFLLine? {
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
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.textLabel?.textColor = UIColor.black
        
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        guard let line = itemForIndexPath(tableView, indexPath: indexPath) else { return indexPath }
        
        if line.color.isLight() {
            cell?.textLabel?.textColor = UIColor.black
        } else {
            cell?.textLabel?.textColor = UIColor.white
        }
        
        return indexPath
    }
    
}
