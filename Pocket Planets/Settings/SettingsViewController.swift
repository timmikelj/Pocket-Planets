//
//  SettingsViewController.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 17/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var darkModeLabel: UILabel!
    @IBOutlet var darkModeSwitch: UISwitch!
    
    private let themeManager = ThemeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = appTitle
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        
        UserDef.darkModeApplied(sender.isOn)
        themeManager.applyTheme(isDarkMode: sender.isOn)
        loadUI()
        
    }
    
    private func loadUI() {
        
        self.title = "Settings"
        
        darkModeSwitch.isOn = UserDef.isDarkMode()
        darkModeSwitch.onTintColor = ppBackgroundColor
        darkModeSwitch.layer.borderWidth = 2
        darkModeSwitch.layer.cornerRadius = 16
        darkModeSwitch.layer.borderColor = ppTextColor.cgColor
        darkModeSwitch.thumbTintColor = ppTextColor
        
        darkModeLabel.textColor = ppTextColor
        
        view.backgroundColor = ppBackgroundColor
 
        navigationController?.navigationBar.tintColor = ppTextColor
        navigationController?.navigationBar.barTintColor = ppBackgroundColor
        
        if UserDef.isDarkMode() {
            navigationController?.navigationBar.barStyle = .blackTranslucent
        } else {
            navigationController?.navigationBar.barStyle = .default
        }
        
    }

}
