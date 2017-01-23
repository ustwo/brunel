//
//  SearchBaseTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit

import SVProgressHUD


protocol SearchableTableItem {
    
    func configureTableViewCell(_ cell: UITableViewCell)
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
                searchController.isActive = false
                navigationItem.rightBarButtonItem?.isEnabled = false
                SVProgressHUD.show()
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = true
                SVProgressHUD.dismiss()
            }
            
            tableView.reloadData()
        }
    }
    
    let cellType: AnyClass
    
    
    // MARK: - Initializers
    
    init(cellType: AnyClass) {
        self.cellType = cellType
        
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            let searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(SearchTableViewController.searchButtonPressed(_:)))
            searchButton.accessibilityIdentifier = AccessibilityIdentifiers.Buttons.SearchButton
            
            navigationItem.rightBarButtonItem = searchButton
        #endif
        
        definesPresentationContext = true
        
        tableView.register(cellType, forCellReuseIdentifier: reuseIdentifier)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Restore the searchController's active state.
        if restoredState.wasActive {
            searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        SVProgressHUD.dismiss()
    }
    
    
    // MARK: - Setup
    
    func setSearchBarPlaceholder(_ placeholder: String) {
        searchController.searchBar.placeholder = placeholder
    }
    
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        resultsTableController?.searchArray.removeAll(keepingCapacity: false)
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        let array = items.filter({
            let searchableStrings = $0.searchableStrings()
            
            for searchableString in searchableStrings {
                if searchableString.uppercased().range(of: searchText.uppercased()) != nil {
                    return true
                }
            }
            
            return false
        })
        resultsTableController?.searchArray = array
    }
    
    
    // MARK: - UISearchControllerDelegate
    
    #if os(iOS)
        func willPresentSearchController(_ searchController: UISearchController) {
            navigationController?.navigationBar.isTranslucent = true
        }
    
        func willDismissSearchController(_ searchController: UISearchController) {
            navigationController?.navigationBar.isTranslucent = false
        }
    #endif
    
    
    // MARK: - UITableViewDatasource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let item = itemForIndexPath(tableView, indexPath: indexPath) {
            item.configureTableViewCell(cell)
        }
        
        return cell
    }
    
    
    // MARK: - Control Actions
    
    func searchButtonPressed(_ sender: UIBarButtonItem) {
        // Present the search controller from the root view controller.
        guard let rootViewController = view.window?.rootViewController else { fatalError("Unable to get root view controller.") }
        rootViewController.present(searchController, animated: true, completion: nil)
    }
    
    
    // MARK: - Convenience
    
    func itemForIndexPath(_ tableView: UITableView, indexPath: IndexPath) -> T? {
        if tableView == self.tableView {
            return items[indexPath.row]
        } else {
            return resultsTableController?.searchArray[indexPath.row]
        }
    }
    
    
    // MARK: - UIStateRestoration
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        // Encode the view state so it can be restored later.
        
        // Encode the title.
        coder.encode(navigationItem.title!, forKey:SearchRestorationKeys.ViewControllerTitle.rawValue)
        
        // Encode the search controller's active state.
        coder.encode(searchController.isActive, forKey:SearchRestorationKeys.SearchControllerIsActive.rawValue)
        
        // Encode the first responser status.
        coder.encode(searchController.searchBar.isFirstResponder, forKey:SearchRestorationKeys.SearchBarIsFirstResponder.rawValue)
        
        // Encode the search bar text.
        coder.encode(searchController.searchBar.text, forKey:SearchRestorationKeys.SearchBarText.rawValue)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        // Restore the title.
        guard let decodedTitle = coder.decodeObject(forKey: SearchRestorationKeys.ViewControllerTitle.rawValue) as? String else {
            fatalError("A title did not exist. In your app, handle this gracefully.")
        }
        title = decodedTitle
        
        // Restore the active state:
        // We can't make the searchController active here since it's not part of the view
        // hierarchy yet, instead we do it in viewWillAppear.
        //
        restoredState.wasActive = coder.decodeBool(forKey: SearchRestorationKeys.SearchControllerIsActive.rawValue)
        
        // Restore the first responder status:
        // Like above, we can't make the searchController first responder here since it's not part of the view
        // hierarchy yet, instead we do it in viewWillAppear.
        //
        restoredState.wasFirstResponder = coder.decodeBool(forKey: SearchRestorationKeys.SearchBarIsFirstResponder.rawValue)
        
        // Restore the text in the search field.
        searchController.searchBar.text = coder.decodeObject(forKey: SearchRestorationKeys.SearchBarText.rawValue) as? String
    }
    
}
