//
//  LineSearchContainerTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 21/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Allows the user to search for lines across transport modes.
final class LineSearchContainerTableViewController: UIViewController, LineSearchTableViewControllerDelegate {
    
    
    // MARK: - Properties
    
    var searchController = UISearchController(searchResultsController: nil)
    
    let searchResultsController = LineSearchTableViewController()
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.searchBarStyle = .Minimal
        searchController.searchBar.placeholder = Strings.Placeholders.SearchLines
        
        navigationItem.titleView = searchController.searchBar
        
        definesPresentationContext = true
        
        searchResultsController.lineSearchDelegate = self
    }
    
    
    // MARK: - LineSearchTableViewControllerDelegate
    
    func lineSearch(lineSearch: LineSearchTableViewController, didSelectLine line: TFLLine) {
        let newViewController = LineDetailViewController()
        let navigationViewController = UINavigationController(rootViewController: newViewController)
        newViewController.detailItem = line
        
        newViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        newViewController.navigationItem.leftItemsSupplementBackButton = true
        
        showDetailViewController(navigationViewController, sender: nil)
    }
    
}
