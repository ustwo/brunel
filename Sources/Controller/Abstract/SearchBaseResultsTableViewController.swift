//
//  SearchBaseResultsTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit


/// Results from searching. It is neccessary to have a separate results view to fully support VoiceOver. See http://www.iaccessibility.net/report/uisearching-for-accessibility-nil for details.
class SearchBaseResultsTableViewController<T: SearchableTableItem>: UITableViewController {
    
    
    // MARK: - Properties
    
    private let reuseIdentifier: String
    
    var searchArray = [T]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let cellType: AnyClass
    
    
    // MARK: - Initializers
    
    init(cellType: AnyClass, reuseIdentifier: String) {
        self.cellType = cellType
        self.reuseIdentifier = reuseIdentifier
        
        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(cellType, forCellReuseIdentifier: reuseIdentifier)
        tableView.estimatedRowHeight = Constants.Sizes.EstimatedCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}
