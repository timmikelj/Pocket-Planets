//
//  ActivityIndicator+Extensions.swift
//  Pocket Planets
//
//  Created by Tim on 17/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    
    func indicator(for button: UIButton) {
        
        let buttonHeight = button.bounds.size.height
        let buttonWidth = button.bounds.size.width
        self.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
        

        if button.backgroundColor != .white {
            self.style = .white
        } else {
            self.style = .gray
        }
        
        button.addSubview(self)
        
        button.setTitle("", for: .normal)
        
    }
    
}

