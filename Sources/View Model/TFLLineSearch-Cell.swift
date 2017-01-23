//
//  TFLLineSearch-Cell.swift
//  Brunel
//
//  Created by Aaron McTavish on 21/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit


extension TFLLineSearch: SearchableTableItem {
    
    func configureTableViewCell(_ cell: UITableViewCell) {
        cell.textLabel?.text = name
        
        cell.contentView.backgroundColor = color
        
        if color.isLight() {
            cell.textLabel?.textColor = UIColor.black
        } else {
            cell.textLabel?.textColor = UIColor.white
        }
        
        cell.accessibilityIdentifier = AccessibilityIdentifiers.Lines.LineCellPrefix + "_\(name)"
    }
    
    func searchableStrings() -> [String] {
        return [name, mode.description]
    }
    
}
