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
let darkModeColor: UIColor = UIColor(displayP3Red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)

class ThemeManager {
    
    private func applyThemeColors(isDarkMode: Bool) {
        
        if isDarkMode {
            ppTextColor = .white
            ppBackgroundColor = darkModeColor
        } else {
            ppTextColor = .black
            ppBackgroundColor = .white
        }
    }
    
    internal func applyTheme(isDarkMode: Bool) {
        
        guard let topVC = UIApplication.topViewController() else { return }
        
        applyThemeColors(isDarkMode: isDarkMode)

        topVC.view.backgroundColor = ppBackgroundColor

        topVC.navigationController?.navigationBar.tintColor = ppTextColor
        topVC.navigationController?.navigationBar.barTintColor = ppBackgroundColor

        if isDarkMode {
            topVC.navigationController?.navigationBar.barStyle = .blackTranslucent
        } else {
            topVC.navigationController?.navigationBar.barStyle = .default
        }
        
    }
    
}
