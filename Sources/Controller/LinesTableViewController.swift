//
//  LinesTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Displays a table of `TFLLine` for a given mode. Fetches current data from the server.
final class LinesTableViewController: LinesPickerBaseTableViewController {
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.Titles.Lines
        
        fetchLines()
    }
    
    
    // MARK: - Fetch Data
    
    private func fetchLines() {
        if let modes = modes {
            
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
    
}
