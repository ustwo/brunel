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
    
    func lineSearch(_ lineSearch: LineSearchTableViewController, didSelectLine line: TFLLine)
    
}


/// Allows user to search for a given line across modes of transportation.
final class LineSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    // MARK: - Properties
    
    fileprivate let reuseIdentifier = "SearchableCell"
    
    fileprivate var items = [TFLLineSearch]() {
        didSet {
            updateModes()
            updateSearchArray()
        }
    }
    
    fileprivate var searchArray = [TFLLineSearch]()
    
    fileprivate var modes = [TFLModes]()
    
    fileprivate var loadingData = false {
        didSet {
            if loadingData {
                navigationItem.rightBarButtonItem?.isEnabled = false
                SVProgressHUD.show()
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = true
                SVProgressHUD.dismiss()
            }
            
            tableView.reloadData()
        }
    }
    
    fileprivate var filterString = "" {
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
                        if searchableString.uppercased().range(of: filterString.uppercased()) != nil {
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
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.Titles.Search
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    // MARK: - Fetch Data
    
    func fetchLines(_ query: String) {
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
    
    func fetchLine(_ lineID: String, completion: @escaping (Bool, TFLLine?) -> Void) {
        guard !lineID.isEmpty else {
            completion(false, nil)
            return
        }
        
        loadingData = true
        TFLRestAPI.sharedInstance.getLineStatus([lineID]) { [weak self] lines, error in
            if let lines = lines, !lines.isEmpty {
                completion(true, lines[0])
            } else {
                print(error)
                completion(false, nil)
            }
            self?.loadingData = false
        }
    }
    
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        filterString = searchController.searchBar.text ?? ""
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return modes.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mode = modes[section]
        
        return searchArray.filter { $0.mode == mode }.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return modes[section].description
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let item = itemForIndexPath(indexPath) {
            item.configureTableViewCell(cell)
        }
        
        return cell
    }
    
    func itemForIndexPath(_ indexPath: IndexPath) -> TFLLineSearch? {
        let mode = modes[indexPath.section]
        
        return searchArray.filter { $0.mode == mode }[indexPath.row]
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = itemForIndexPath(indexPath) else { return }
        
        fetchLine(item.identifier) { [weak self] success, line in
            if success, let line = line, let strongSelf = self {
                strongSelf.lineSearchDelegate?.lineSearch(strongSelf, didSelectLine: line)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.textLabel?.textColor = UIColor.black
        
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath)
        guard let item = itemForIndexPath(indexPath) else { return indexPath }
        
        if item.color.isLight() {
            cell?.textLabel?.textColor = UIColor.black
        } else {
            cell?.textLabel?.textColor = UIColor.white
        }
        
        return indexPath
    }
    
    
    // MARK: - Convenience
    
    fileprivate func updateModes() {
        modes.removeAll()
        
        for item in items {
            if !modes.contains(item.mode) {
                modes.append(item.mode)
            }
        }
        
        modes.sorted { $0.description < $1.description }
    }
    
    fileprivate func updateSearchArray() {
        if filterString.isEmpty {
            searchArray.removeAll()
        } else {
            searchArray = items.filter {
                let searchableStrings = $0.searchableStrings()
                
                for searchableString in searchableStrings {
                    if searchableString.uppercased().range(of: filterString.uppercased()) != nil {
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
