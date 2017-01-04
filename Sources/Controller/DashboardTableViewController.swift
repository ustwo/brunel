//
//  DashboardTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

import SVProgressHUD


/// Displays a table of `TFLLine` for a given mode and their statuses, scrolling through the list automatically.
final class DashboardTableViewController: LinesBaseTableViewController {
    
    
    // MARK: - Properties
    
    fileprivate var scrollingTimer: Timer?
    fileprivate var topIndex: IndexPath?
    fileprivate var shownLastIndex = false
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LineDetailTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.isUserInteractionEnabled = false
        tableView.tableHeaderView = nil
        
        title = Strings.Titles.Dashboard
        
        fetchLines()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scrollingTimer = Timer.scheduledTimer(timeInterval: Constants.Animation.Scrolling, target: self, selector: #selector(DashboardTableViewController.scrollingTimerFired(_:)), userInfo: nil, repeats: true)
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        scrollingTimer?.invalidate()
        
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: - Fetch Data
    
    fileprivate func fetchLines() {
        if let modes = modes {
            if let firstMode = modes.first {
                title = firstMode.description + " " + Strings.Titles.Dashboard
                
                let tintColor: UIColor
                if firstMode.color.isLight() {
                    tintColor = UIColor.black
                } else {
                    tintColor = UIColor.white
                }
                
                navigationController?.navigationBar.barTintColor = firstMode.color
                navigationController?.navigationBar.tintColor = tintColor
                navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: tintColor, NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)]
            }
            
            loadingData = true
            TFLRestAPI.sharedInstance.getLineStatus(modes) { [weak self] lines, error in
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
    }
    
    
    // MARK: - UITableViewDatasource
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    
    // MARK: - Scrolling
    
    func scrollingTimerFired(_ timer: Timer) {
        let allIndices = allIndexPaths()
        
        guard !allIndices.isEmpty else { return }
        
        var newTopIndex: IndexPath
        if let topIndex = topIndex,
            var index = allIndices.index(of: topIndex) {
                index += 1
                if index >= allIndices.count {
                    index = 0
                } else if let lastIndex = allIndices.last,
                    let visibleRows = tableView.indexPathsForVisibleRows, visibleRows.contains(lastIndex) {
                        if shownLastIndex {
                            index = 0
                        } else {
                            shownLastIndex = true
                        }
                }
                
                newTopIndex = allIndices[index]
        } else {
            newTopIndex = allIndices.count > 1 ? allIndices[1] : allIndices[0]
        }
        
        topIndex = newTopIndex
        
        tableView.scrollToRow(at: newTopIndex, at: .top, animated: true)
    }
    
    fileprivate func allIndexPaths() -> [IndexPath] {
        var result = [IndexPath]()
        
        for sectionIndex in 0 ..< tableView.numberOfSections {
            for rowIndex in 0 ..< tableView.numberOfRows(inSection: sectionIndex) {
                result.append(IndexPath(row: rowIndex, section: sectionIndex))
            }
        }
        
        return result
    }
    
}
