//
//  UIView+Extensions.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 20/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
