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
    private let reuseIdentifier = "ActionCell"
    
    /// Actions that can be taken. Each action is displayed as a cell in the table.
    private enum Actions: Int {
        case Recent
        case Lines
        case Dashboard
        case Search
        
        static let allValues = [Recent, Lines, Dashboard, Search]
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.estimatedRowHeight = Constants.Sizes.EstimatedCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        title = Strings.Titles.Tools
        
        navigationController?.navigationBar.barTintColor = Constants.Colors.BlueColor
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)]
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Actions.allValues.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        var text: String?
        
        if let selectedAction = Actions(rawValue: indexPath.row) {
            switch selectedAction {
            case .Dashboard:
                text = Strings.Titles.Dashboard
            case .Lines:
                text = Strings.Titles.Lines
            case .Recent:
                text = Strings.Titles.Recent
            case .Search:
                text = Strings.Titles.Search
            }
        }
        
        guard let myText = text else {
                return
        }
        
        cell.textLabel?.text = myText
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .ByWordWrapping
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newViewController: UIViewController?
        
        if let selectedAction = Actions(rawValue: indexPath.row) {
            switch selectedAction {
            case .Dashboard:
                newViewController = ModesToDashboardTableViewController()
            case .Lines:
                newViewController = ModesToLinesTableViewController()
            case .Recent:
                newViewController = RecentLinesTableViewController()
            case .Search:
                presentSearch()
                return
            }
        }
        
        if let newViewController = newViewController {
            showViewController(newViewController, sender: nil)
        }
    }
    
    private func presentSearch() {
        #if os(iOS)
            let newViewController = LineSearchContainerTableViewController()
            
            showViewController(newViewController, sender: nil)
        #else
            let newViewController = LineSearchTableViewController()
            newViewController.lineSearchDelegate = self
            
            // Create and configure a `UISearchController`.
            let searchController = UISearchController(searchResultsController: newViewController)
            searchController.searchResultsUpdater = newViewController
            searchController.hidesNavigationBarDuringPresentation = false
            
            // Present the search controller from the root view controller.
            guard let rootViewController = view.window?.rootViewController else { fatalError("Unable to get root view controller.") }
            rootViewController.presentViewController(searchController, animated: true, completion: nil)
        #endif
    }
    
    
    // MARK: - LineSearchTableViewControllerDelegate
    
    func lineSearch(lineSearch: LineSearchTableViewController, didSelectLine line: TFLLine) {
        let newViewController = LineDetailViewController()
        let navigationViewController = UINavigationController(rootViewController: newViewController)
        newViewController.detailItem = line
        
        newViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        
        showDetailViewController(navigationViewController, sender: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
