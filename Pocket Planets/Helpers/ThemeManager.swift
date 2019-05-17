//
//  ThemeManager.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 17/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

var ppTextColor: UIColor = .black
var ppBackgroundColor: UIColor = .white

class ThemeManager {
    
    private func applyThemeColors(isDarkMode: Bool) {
        
        if isDarkMode {
            ppTextColor = .white
            ppBackgroundColor = .darkGray
        } else {
            ppTextColor = .black
            ppBackgroundColor = .white
        }
    }
    
    internal func applyTheme(isDarkMode: Bool) {
        
        applyThemeColors(isDarkMode: isDarkMode)
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: ppTextColor]
        UINavigationBar.appearance().tintColor = ppBackgroundColor
        UIBarButtonItem.appearance().tintColor = ppTextColor
        
    }
    
}
