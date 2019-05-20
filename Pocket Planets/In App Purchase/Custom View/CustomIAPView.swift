//
//  CustomIAPView.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 20/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

class CustomIAPView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var purchaseFullAccessButton: UIButton!
    @IBOutlet var restorePurchaseButton: UIButton!
    @IBOutlet var priceLabel: UILabel!
    
    private let nibName = "CustomIAPView"
    private let topConstraintConstant: CGFloat = -250
    lazy var topConstraint = self.topAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.topAnchor, constant: -150)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        contentView.fixInView(self)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.7
        contentView.layer.shadowRadius = 6
        notificationIconView.layer.cornerRadius = notificationIconView.frame.height/2
        notificationIconView.backgroundColor = .white
        
    }
    
    func setupWithConstraints(to view: UIView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            self.widthAnchor.constraint(equalToConstant: view.frame.width - 28),
            self.heightAnchor.constraint(equalToConstant: 44)
            ])
        
        topConstraint.constant = topConstraintConstant
        topConstraint.isActive = true
        
        self.superview?.bringSubviewToFront(self)
    }
    
    
}

