//
//  ToolsTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Allows the user to choose the tool to use for displaying data in the detail view (e.g. Recent Lines, Dashboard, etc.).
final class ToolsTableViewController: UITableViewController, LineSearchTableViewControllerDelegate {
    
    
    // MARK: - Properties
    
    /// Reuse identifier for the table cells.
    fileprivate let reuseIdentifier = "ActionCell"
    
    /// Actions that can be taken. Each action is displayed as a cell in the table.
    fileprivate enum Actions: Int {
        case recent
        case lines
        case dashboard
        case search
        
        static let allValues = [recent, lines, dashboard, search]
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.estimatedRowHeight = Constants.Sizes.EstimatedCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        title = Strings.Titles.Tools
        
        navigationController?.navigationBar.barTintColor = Constants.Colors.BlueColor
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)]
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Actions.allValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        var text: String?
        
        if let selectedAction = Actions(rawValue: indexPath.row) {
            switch selectedAction {
            case .dashboard:
                text = Strings.Titles.Dashboard
            case .lines:
                text = Strings.Titles.Lines
            case .recent:
                text = Strings.Titles.Recent
            case .search:
                text = Strings.Titles.Search
            }
        }
        
        guard let myText = text else {
                return
        }
        
        cell.textLabel?.text = myText
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var newViewController: UIViewController?
        
        if let selectedAction = Actions(rawValue: indexPath.row) {
            switch selectedAction {
            case .dashboard:
                newViewController = ModesToDashboardTableViewController()
            case .lines:
                newViewController = ModesToLinesTableViewController()
            case .recent:
                newViewController = RecentLinesTableViewController()
            case .search:
                presentSearch()
                return
            }
        }
        
        if let newViewController = newViewController {
            show(newViewController, sender: nil)
        }
    }
    
    fileprivate func presentSearch() {
        #if os(iOS)
            let newViewController = LineSearchContainerTableViewController()
            
            show(newViewController, sender: nil)
        #else
            let newViewController = LineSearchTableViewController()
            newViewController.lineSearchDelegate = self
            
            // Create and configure a `UISearchController`.
            let searchController = UISearchController(searchResultsController: newViewController)
            searchController.searchResultsUpdater = newViewController
            searchController.hidesNavigationBarDuringPresentation = false
            
            // Present the search controller from the root view controller.
            guard let rootViewController = view.window?.rootViewController else { fatalError("Unable to get root view controller.") }
            rootViewController.present(searchController, animated: true, completion: nil)
        #endif
    }
    
    
    // MARK: - LineSearchTableViewControllerDelegate
    
    func lineSearch(_ lineSearch: LineSearchTableViewController, didSelectLine line: TFLLine) {
        let newViewController = LineDetailViewController()
        let navigationViewController = UINavigationController(rootViewController: newViewController)
        newViewController.detailItem = line
        
        newViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        
        showDetailViewController(navigationViewController, sender: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
}
