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
    
    private var scrollingTimer: NSTimer?
    private var topIndex: NSIndexPath?
    private var shownLastIndex = false
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(LineDetailTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.userInteractionEnabled = false
        tableView.tableHeaderView = nil
        
        title = Strings.Titles.Dashboard
        
        fetchLines()
    }
    
    override func viewWillAppear(animated: Bool) {
        scrollingTimer = NSTimer.scheduledTimerWithTimeInterval(Constants.Animation.Scrolling, target: self, selector: #selector(DashboardTableViewController.scrollingTimerFired(_:)), userInfo: nil, repeats: true)
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        scrollingTimer?.invalidate()
        
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: - Fetch Data
    
    private func fetchLines() {
        if let modes = modes {
            if let firstMode = modes.first {
                title = firstMode.description + " " + Strings.Titles.Dashboard
                
                let tintColor: UIColor
                if firstMode.color.isLight() {
                    tintColor = UIColor.blackColor()
                } else {
                    tintColor = UIColor.whiteColor()
                }
                
                navigationController?.navigationBar.barTintColor = firstMode.color
                navigationController?.navigationBar.tintColor = tintColor
                navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : tintColor, NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)]
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
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    
    // MARK: - Scrolling
    
    func scrollingTimerFired(timer: NSTimer) {
        let allIndices = allIndexPaths()
        
        guard !allIndices.isEmpty else { return }
        
        var newTopIndex: NSIndexPath
        if let topIndex = topIndex,
            var index = allIndices.indexOf(topIndex) {
                index += 1
                if index >= allIndices.count {
                    index = 0
                } else if let lastIndex = allIndices.last,
                    visibleRows = tableView.indexPathsForVisibleRows where visibleRows.contains(lastIndex) {
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
        
        tableView.scrollToRowAtIndexPath(newTopIndex, atScrollPosition: .Top, animated: true)
    }
    
    private func allIndexPaths() -> [NSIndexPath] {
        var result = [NSIndexPath]()
        
        for sectionIndex in 0 ..< tableView.numberOfSections {
            for rowIndex in 0 ..< tableView.numberOfRowsInSection(sectionIndex) {
                result.append(NSIndexPath(forRow: rowIndex, inSection: sectionIndex))
            }
        }
        
        return result
    }
    
}
