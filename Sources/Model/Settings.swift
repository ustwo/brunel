//
//  Settings.swift
//  Brunel
//
//  Created by Aaron McTavish on 19/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation


/**
 *  App settings.
 */
struct Settings {
    
    
    // MARK: - Types
    
    /**
    *  `NSUserDefaults` keys for settings.
    */
    private struct SettingsKeys {
        static let RecentLines  = "RecentLines"
    }
    
    
    // MARK: - Properties
    
    /// Single shared instance for `Settings`.
    static var sharedInstance = Settings()
    
    /// `NSNotification` name for when the settings change.
    static let SettingsChangedNotification = "SettingsChanged"
    
    var recentLines: [String] {
        didSet {
            saveSettings()
        }
    }
    
    
    // MARK: - Initializers
    
    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let lines = defaults.arrayForKey(SettingsKeys.RecentLines) as? [String] {
            recentLines = lines
        } else {
            recentLines = [String]()
        }
    }
    
    
    // MARK: - Save Changes
    
    /**
    Save the settings into `NSUserDefaults`.
    */
    private func saveSettings() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(recentLines, forKey: SettingsKeys.RecentLines)
        defaults.synchronize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(Settings.SettingsChangedNotification, object: nil)
    }
    
    
    // MARK: - Convenience
    
    /**
    Register the default `Settings` settings.
    */
    static func registerSettings() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.registerDefaults([SettingsKeys.RecentLines : [String]()])
    }
    
}
