//
//  ModesToLinesTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


/// Table of modes of transportation that, when selected, displays a table of lines for that mode for further selection/refinement.
final class ModesToLinesTableViewController: ModesBaseTableViewController {
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = itemForIndexPath(indexPath)
        
        let controller = LinesTableViewController(modes: [item])
        showViewController(controller, sender: nil)
    }


}
