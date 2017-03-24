//
//  LineWikiViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 02/02/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//


import SVProgressHUD
import UIKit


/// Displays the introduction to the Wikipedia page with details for a given `TFLLine`.
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

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = line.name + " Wiki"
        
        fetchWiki()
    }
    
    override func setupView() {
        super.setupView()
        
        underlyingView.backButton.addTarget(self, action: #selector(LineWikiViewController.backButtonPressed(_:)), for: .primaryActionTriggered)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        SVProgressHUD.dismiss()
    }
    
    
    // MARK: - Fetch Data
    
    private func fetchWiki() {
        SVProgressHUD.show()
        WikipediaRestAPI.sharedInstance.getQueryTitle(lineWikiDetail.wikipediaPageName) { [weak self] wikiPage, error in
            if let wikiPage = wikiPage {
                let wikiText = "Wikipedia:\n\n" + wikiPage
                DispatchQueue.main.async {
                    self?.underlyingView.wikiLabel.text = wikiText
                }
            } else if let error = error {
                print(error)
            } else {
                print("Unknown Error")
            }
            
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    
    // MARK: - Control Actions
    
    func backButtonPressed(_ sender: UIButton) {
        // swiftlint:disable:next redundant_discardable_let
        let _ = navigationController?.popViewController(animated: true)
    }
    
}
