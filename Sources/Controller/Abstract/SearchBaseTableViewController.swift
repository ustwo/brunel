//
//  SearchBaseTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

import SVProgressHUD


protocol SearchableTableItem {
    
    func configureTableViewCell(cell: UITableViewCell)
    func searchableStrings() -> [String]
    
}

/// State restoration values.
private enum SearchRestorationKeys: String {
    case ViewControllerTitle
    case SearchControllerIsActive
    case SearchBarText
    case SearchBarIsFirstResponder
}

private struct SearchControllerRestorableState {
    var wasActive = false
    var wasFirstResponder = false
}


/// Base `UITableViewController` for presenting searchable data.
class SearchTableViewController<T: SearchableTableItem>: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    
    // MARK: - Properties
    
    let reuseIdentifier = "SearchableCell"
    
    var items = [T]()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    /// Results table displayed when searching.
    var resultsTableController: SearchBaseResultsTableViewController<T>?
    
    /// Restoration state for UISearchController
    private var restoredState = SearchControllerRestorableState()
    
    var loadingData = false {
        didSet {
            if loadingData {
                items = [T]()
                searchController.active = false
                navigationItem.rightBarButtonItem?.enabled = false
                SVProgressHUD.show()
            } else {
                navigationItem.rightBarButtonItem?.enabled = true
                SVProgressHUD.dismiss()
            }
            
            tableView.reloadData()
        }
    }
    
    let cellType: AnyClass
    
    
    // MARK: - Initializers
    
    init(cellType: AnyClass) {
        self.cellType = cellType
        
        super.init(style: .Plain)
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableController = SearchBaseResultsTableViewController<T>(cellType: cellType, reuseIdentifier: reuseIdentifier)
        resultsTableController?.tableView.dataSource = self
        resultsTableController?.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        #if os(iOS)
            tableView.tableHeaderView = searchController.searchBar
            
            searchController.dimsBackgroundDuringPresentation = false
        #else
            let searchButton = UIBarButtonItem(title: "Search", style: .Plain, target: self, action: #selector(SearchTableViewController.searchButtonPressed(_:)))
            searchButton.accessibilityIdentifier = AccessibilityIdentifiers.Buttons.SearchButton
            
            navigationItem.rightBarButtonItem = searchButton
        #endif
        
        definesPresentationContext = true
        
        tableView.registerClass(cellType, forCellReuseIdentifier: reuseIdentifier)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Restore the searchController's active state.
        if restoredState.wasActive {
            searchController.active = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        SVProgressHUD.dismiss()
    }
    
    
    // MARK: - Setup
    
    func setSearchBarPlaceholder(placeholder: String) {
        searchController.searchBar.placeholder = placeholder
    }
    
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        resultsTableController?.searchArray.removeAll(keepCapacity: false)
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        let array = items.filter({
            let searchableStrings = $0.searchableStrings()
            
            for searchableString in searchableStrings {
                if searchableString.uppercaseString.rangeOfString(searchText.uppercaseString) != nil {
                    return true
                }
            }
            
            return false
        })
        resultsTableController?.searchArray = array
    }
    
    
    // MARK: - UISearchControllerDelegate
    
    #if os(iOS)
        func willPresentSearchController(searchController: UISearchController) {
            navigationController?.navigationBar.translucent = true
        }
    
        func willDismissSearchController(searchController: UISearchController) {
            navigationController?.navigationBar.translucent = false
        }
    #endif
    
    
    // MARK: - UITableViewDatasource
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        if let item = itemForIndexPath(tableView, indexPath: indexPath) {
            item.configureTableViewCell(cell)
        }
        
        return cell
    }
    
    
    // MARK: - Control Actions
    
    func searchButtonPressed(sender: UIBarButtonItem) {
        // Present the search controller from the root view controller.
        guard let rootViewController = view.window?.rootViewController else { fatalError("Unable to get root view controller.") }
        rootViewController.presentViewController(searchController, animated: true, completion: nil)
    }
    
    
    // MARK: - Convenience
    
    func itemForIndexPath(tableView: UITableView, indexPath: NSIndexPath) -> T? {
        if tableView == self.tableView {
            return items[indexPath.row]
        } else {
            return resultsTableController?.searchArray[indexPath.row]
        }
    }
    
    
    // MARK: - UIStateRestoration
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        super.encodeRestorableStateWithCoder(coder)
        
        // Encode the view state so it can be restored later.
        
        // Encode the title.
        coder.encodeObject(navigationItem.title!, forKey:SearchRestorationKeys.ViewControllerTitle.rawValue)
        
        // Encode the search controller's active state.
        coder.encodeBool(searchController.active, forKey:SearchRestorationKeys.SearchControllerIsActive.rawValue)
        
        // Encode the first responser status.
        coder.encodeBool(searchController.searchBar.isFirstResponder(), forKey:SearchRestorationKeys.SearchBarIsFirstResponder.rawValue)
        
        // Encode the search bar text.
        coder.encodeObject(searchController.searchBar.text, forKey:SearchRestorationKeys.SearchBarText.rawValue)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        super.decodeRestorableStateWithCoder(coder)
        
        // Restore the title.
        guard let decodedTitle = coder.decodeObjectForKey(SearchRestorationKeys.ViewControllerTitle.rawValue) as? String else {
            fatalError("A title did not exist. In your app, handle this gracefully.")
        }
        title = decodedTitle
        
        // Restore the active state:
        // We can't make the searchController active here since it's not part of the view
        // hierarchy yet, instead we do it in viewWillAppear.
        //
        restoredState.wasActive = coder.decodeBoolForKey(SearchRestorationKeys.SearchControllerIsActive.rawValue)
        
        // Restore the first responder status:
        // Like above, we can't make the searchController first responder here since it's not part of the view
        // hierarchy yet, instead we do it in viewWillAppear.
        //
        restoredState.wasFirstResponder = coder.decodeBoolForKey(SearchRestorationKeys.SearchBarIsFirstResponder.rawValue)
        
        // Restore the text in the search field.
        searchController.searchBar.text = coder.decodeObjectForKey(SearchRestorationKeys.SearchBarText.rawValue) as? String
    }
    
}
