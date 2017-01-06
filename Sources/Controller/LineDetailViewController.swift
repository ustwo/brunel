//
//  LineDetailViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Displays the status details for a given `TFLLine`.
final class LineDetailViewController: BaseViewController<DetailView> {

    
    // MARK: - Properties

    var detailItem: TFLLine? {
        didSet {
            setupView()
            updateSettings()
        }
    }
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.Titles.Status
        
        navigationController?.navigationBar.isTranslucent = false
        
        if navigationItem.leftBarButtonItem == nil {
            navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        }
    }
    
    
    // MARK: - Setup
    
    override func setupView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            underlyingView.nameLabel.text = detail.name
            underlyingView.statusLabel.text = detail.lineStatuses.first?.severityDescription
            
            if let disruption = detail.lineStatuses.first?.disruption,
                let additionalInfo = disruption.additionalInfo {
                    underlyingView.disruptionLabel.text = additionalInfo
                    underlyingView.disruptionLabel.isHidden = false
            }
            
            let tintColor: UIColor
            if detail.color.isLight() {
                tintColor = UIColor.black
            } else {
                tintColor = UIColor.white
            }
            
            navigationController?.navigationBar.barTintColor = detail.color
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: tintColor, NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)]
            
            #if os(tvOS)
                setupTV()
            #endif
        }
    }
    
    
    // MARK: - Settings
    
    func updateSettings() {
        guard let detailItem = detailItem else { return }
        
        let identifier = detailItem.identifier
        
        var recentLines = Settings.sharedInstance.recentLines
        
        if let index = recentLines.index(of: identifier) {
            recentLines.remove(at: index)
            recentLines.insert(identifier, at: 0)
        } else {
            recentLines.insert(identifier, at: 0)
            if recentLines.count > Constants.Settings.MaxRecentLines {
                recentLines.removeLast()
            }
        }
        
        Settings.sharedInstance.recentLines = recentLines
    }
    
    
    // MARK: - Control Actions
    
    #if os(tvOS)
        func aboutButtonPressed(_ sender: UIButton) {
            guard let line = detailItem,
                let lineWikiDetail = lineWikipediaDetail() else {
                    return
            }
            
            let viewController = LineWikiViewController(line: line, lineWikiDetail: lineWikiDetail)
            viewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            
            show(viewController, sender: nil)
        }
    #endif

}
