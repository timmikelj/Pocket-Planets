//
//  Alert+Extensions.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func showOneButtonAlert(title: String?, buttonTitle: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        
        alert.view.tintColor = ppTextColor
        
        if let topVC = UIApplication.topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    
    }
}
