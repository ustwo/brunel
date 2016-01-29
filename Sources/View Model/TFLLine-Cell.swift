//
//  TFLLine-Cell.swift
//  Brunel
//
//  Created by Aaron McTavish on 20/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import UIKit


extension TFLLine: SearchableTableItem {
    
    func configureTableViewCell(cell: UITableViewCell) {
        if let lineCell = cell as? LineDetailTableViewCell {
            lineCell.statusSection.lineLabel.textLabel.text = name
            
            lineCell.statusSection.lineLabel.backgroundColor = color
            
            if color.isLight() {
                lineCell.statusSection.lineLabel.textLabel.textColor = UIColor.blackColor()
            } else {
                lineCell.statusSection.lineLabel.textLabel.textColor = UIColor.whiteColor()
            }
            
            var statusText = ""
            var statusTextColor = UIColor.blackColor()
            var statusBackgroundColor = UIColor.whiteColor()
            if !lineStatuses.isEmpty {
                var statusTextResult = ""
                var usedStatuses = [String]()
                
                for lineStatus in lineStatuses where !usedStatuses.contains(lineStatus.severityDescription) {
                    if !statusTextResult.isEmpty {
                        statusTextResult += ", "
                        
                    } else {
                        if lineStatus.severity != 10 {
                            statusTextColor = UIColor.whiteColor()
                            statusBackgroundColor = UIColor.purpleColor()
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
            
            lineCell.selectionStyle = .None
            
            lineCell.accessibilityIdentifier = AccessibilityIdentifiers.Lines.LineDetailCellPrefix + "_\(name)"
        } else {
            cell.textLabel?.text = name
            
            cell.contentView.backgroundColor = color
            
            if color.isLight() {
                cell.textLabel?.textColor = UIColor.blackColor()
            } else {
                cell.textLabel?.textColor = UIColor.whiteColor()
            }
            
            cell.accessibilityIdentifier = AccessibilityIdentifiers.Lines.LineCellPrefix + "_\(name)"
        }
    }
    
    func searchableStrings() -> [String] {
        return [name, mode.description]
    }
    
}
