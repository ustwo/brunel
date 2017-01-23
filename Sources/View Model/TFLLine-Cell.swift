//
//  TFLLine-Cell.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo Fampany Ltd. All rights reserved.
//

import UIKit


extension TFLLine: SearchableTableItem {
    
    func configureTableViewCell(_ cell: UITableViewCell) {
        if let lineCell = cell as? LineDetailTableViewCell {
            lineCell.statusSection.lineLabel.textLabel.text = name
            
            lineCell.statusSection.lineLabel.backgroundColor = color
            
            if color.isLight() {
                lineCell.statusSection.lineLabel.textLabel.textColor = UIColor.black
            } else {
                lineCell.statusSection.lineLabel.textLabel.textColor = UIColor.white
            }
            
            var statusText = ""
            var statusTextColor = UIColor.black
            var statusBackgroundColor = UIColor.white
            if !lineStatuses.isEmpty {
                var statusTextResult = ""
                var usedStatuses = [String]()
                
                for lineStatus in lineStatuses where !usedStatuses.contains(lineStatus.severityDescription) {
                    if !statusTextResult.isEmpty {
                        statusTextResult += ", "
                        
                    } else {
                        if lineStatus.severity != 10 {
                            statusTextColor = UIColor.white
                            statusBackgroundColor = UIColor.purple
                        }
                    }
                    
                    statusTextResult += lineStatus.severityDescription
                    usedStatuses.append(lineStatus.severityDescription)
                }
                
                statusText = statusTextResult
            }
            lineCell.statusSection.statusLabel.textLabel.text = statusText
            lineCell.statusSection.statusLabel.textLabel.textColor = statusTextColor
            lineCell.statusSection.statusLabel.backgroundColor = statusBackgroundColor
            
            lineCell.selectionStyle = .none
            
            lineCell.accessibilityIdentifier = AccessibilityIdentifiers.Lines.LineDetailCellPrefix + "_\(name)"
        } else {
            cell.textLabel?.text = name
            
            cell.contentView.backgroundColor = color
            
            if color.isLight() {
                cell.textLabel?.textColor = UIColor.black
            } else {
                cell.textLabel?.textColor = UIColor.white
            }
            
            cell.accessibilityIdentifier = AccessibilityIdentifiers.Lines.LineCellPrefix + "_\(name)"
        }
    }
    
    func searchableStrings() -> [String] {
        return [name, mode.description]
    }
    
}
