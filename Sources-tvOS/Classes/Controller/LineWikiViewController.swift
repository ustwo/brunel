//
//  LineWikiViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 02/02/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit

import SVProgressHUD


final class LineWikiViewController: BaseViewController<LineWikiView> {
    
    
    // MARK: - Properties
    
    private let line: TFLLine
    private var lineWikiDetail: WikipediaSearchable
    
    
    // MARK: - Initializers
    
    init(line: TFLLine, lineWikiDetail: WikipediaSearchable) {
        self.line = line
        self.lineWikiDetail = lineWikiDetail
        
        super.init()
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = line.name + " Wiki"
        
        fetchWiki()
    }
    
    override func setupView() {
        super.setupView()
        
        underlyingView.backButton.addTarget(self, action: Selector("backButtonPressed:"), forControlEvents: .PrimaryActionTriggered)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        SVProgressHUD.dismiss()
    }
    
    
    // MARK: - Fetch Data
    
    private func fetchWiki() {
        SVProgressHUD.show()
        WikipediaRestAPI.sharedInstance.getQueryTitle(title: lineWikiDetail.wikipediaPageName) { [weak self] wikiPage, error in
            if let wikiPage = wikiPage {
                let wikiText = "Wikipedia:\n\n" + wikiPage
                dispatch_async(dispatch_get_main_queue()) {
                    self?.underlyingView.wikiLabel.text = wikiText
                }
            } else if let error = error {
                print(error)
            } else {
                print("Unknown Error")
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    
    // MARK: - Control Actions
    
    func backButtonPressed(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}
