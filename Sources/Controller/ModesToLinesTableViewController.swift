//
//  ModesToLinesTableViewController.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit


/// Table of modes of transportation that, when selected, displays a table of lines for that mode for further selection/refinement.
final class ModesToLinesTableViewController: ModesBaseTableViewController {
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemForIndexPath(indexPath)
        
        let controller = LinesTableViewController(modes: [item])
        show(controller, sender: nil)
    }


}
