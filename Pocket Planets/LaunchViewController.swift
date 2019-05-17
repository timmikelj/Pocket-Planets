//
//  LaunchViewController.swift
//  Pocket Planets
//
//  Created by Tim on 17/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDef.isDarkMode() {
            
            view.backgroundColor = darkModeColor
            titleLabel.textColor = .white
            
        } else {
            
            view.backgroundColor = .white
            titleLabel.textColor = .black
        }
        
    }

    
    
}
