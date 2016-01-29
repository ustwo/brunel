//
//  LineSearchTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 21/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

import SVProgressHUD


protocol LineSearchTableViewControllerDelegate: class {
    
    func lineSearch(lineSearch: LineSearchTableViewController, didSelectLine line: TFLLine)
    
}


/// Allows user to search for a given line across modes of transportation.
final class LineSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    // MARK: - Properties
    
    private let reuseIdentifier = "SearchableCell"
    
    private var items = [TFLLineSearch]() {
        didSet {
            updateModes()
            updateSearchArray()
        }
    }
    
    private var searchArray = [TFLLineSearch]()
    
    private var modes = [TFLModes]()
    
    private var loadingData = false {
        didSet {
            if loadingData {
                navigationItem.rightBarButtonItem?.enabled = false
                SVProgressHUD.show()
            } else {
                navigationItem.rightBarButtonItem?.enabled = true
                SVProgressHUD.dismiss()
            }
            
            tableView.reloadData()
        }
    }
    
    private var filterString = "" {
        didSet {
            guard filterString != oldValue else { return }
            
            if filterString.isEmpty {
                searchArray.removeAll()
            } else if oldValue.isEmpty && filterString.characters.count == 1 {
                // Fetch new data
                fetchLines(filterString)
            } else {
                searchArray = items.filter {
                    let searchableStrings = $0.searchableStrings()
                    
                    for searchableString in searchableStrings {
                        if searchableString.uppercaseString.rangeOfString(filterString.uppercaseString) != nil {
                            return true
                        }
                    }
                    
                    return false
                }
            }
            
            tableView.reloadData()
        }
    }
    
    weak var lineSearchDelegate: LineSearchTableViewControllerDelegate?
    
    
    // MARK: - Initializer
    
    init() {
        super.init(style: .Plain)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.Titles.Search
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    // MARK: - Fetch Data
    
    func fetchLines(query: String) {
        guard !query.isEmpty else {
            items.removeAll()
            return
        }
        
        loadingData = true
        TFLRestAPI.sharedInstance.getLineSearch(query) { [weak self] lines, error in
            if let lines = lines {
                self?.items = lines
            } else if let error = error {
                print(error)
            } else {
                print("Unknown Error")
            }
            self?.loadingData = false
        }
    }
    
    func fetchLine(lineID: String, completion: (Bool, TFLLine?) -> Void) {
        guard !lineID.isEmpty else {
            completion(false, nil)
            return
        }
        
        loadingData = true
        TFLRestAPI.sharedInstance.getLineStatus([lineID]) { [weak self] lines, error in
            if let lines = lines where !lines.isEmpty {
                completion(true, lines[0])
            } else {
                print(error)
                completion(false, nil)
            }
            self?.loadingData = false
        }
    }
    
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterString = searchController.searchBar.text ?? ""
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return modes.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mode = modes[section]
        
        return searchArray.filter { $0.mode == mode }.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return modes[section].description
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        if let item = itemForIndexPath(indexPath) {
            item.configureTableViewCell(cell)
        }
        
        return cell
    }
    
    func itemForIndexPath(indexPath: NSIndexPath) -> TFLLineSearch? {
        let mode = modes[indexPath.section]
        
        return searchArray.filter { $0.mode == mode }[indexPath.row]
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let item = itemForIndexPath(indexPath) else { return }
        
        fetchLine(item.identifier) { [weak self] success, line in
            if success, let line = line, strongSelf = self {
                strongSelf.lineSearchDelegate?.lineSearch(strongSelf, didSelectLine: line)
            }
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.textLabel?.textColor = UIColor.blackColor()
        
        return indexPath
    }
    
    override func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        guard let item = itemForIndexPath(indexPath) else { return indexPath }
        
        if item.color.isLight() {
            cell?.textLabel?.textColor = UIColor.blackColor()
        } else {
            cell?.textLabel?.textColor = UIColor.whiteColor()
        }
        
        return indexPath
    }
    
    
    // MARK: - Convenience
    
    private func updateModes() {
        modes.removeAll()
        
        for item in items {
            if !modes.contains(item.mode) {
                modes.append(item.mode)
            }
        }
        
        modes.sortInPlace { $0.description < $1.description }
    }
    
    private func updateSearchArray() {
        if filterString.isEmpty {
            searchArray.removeAll()
        } else {
            searchArray = items.filter {
                let searchableStrings = $0.searchableStrings()
                
                for searchableString in searchableStrings {
                    if searchableString.uppercaseString.rangeOfString(filterString.uppercaseString) != nil {
                        return true
                    }
                }
                
                return false
            }
            
            let _ = 1
        }
        
        tableView.reloadData()
    }
    
}
