//
//  CustomIAPView.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 20/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

private let purchaseButtonTitle = "Purchase Full Access"
private let restoredButtonTitle = "Restore Full Access"
private let nibName = "CustomIAPView"

class CustomIAPView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var purchaseFullAccessButton: UIButton!
    @IBOutlet var restorePurchaseButton: UIButton!
    @IBOutlet var priceLabel: UILabel!
    
    private let iapBrain = InAppPurchaseBrain()
    private let purchaseIndicator = UIActivityIndicatorView()

    lazy var bottomConstraint = self.bottomAnchor.constraint(equalTo: self.superview!.safeAreaLayoutGuide.bottomAnchor, constant: 0)
    
    private var tableView: UITableView!
    private var tableViewBottomConstraint: NSLayoutConstraint!
    
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
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 2
        
        if ppTextColor == .black {
            contentView.backgroundColor = darkModeColor
        } else {
            contentView.backgroundColor = ppTextColor
        }
        
        purchaseFullAccessButton.isHidden = true
        restorePurchaseButton.isHidden = true
        purchaseFullAccessButton.layer.cornerRadius = 8
        
        purchaseFullAccessButton.backgroundColor = ppBackgroundColor
        purchaseFullAccessButton.setTitleColor(ppTextColor, for: .normal)
        restorePurchaseButton.setTitleColor(ppBackgroundColor, for: .normal)
        priceLabel.textColor = ppBackgroundColor
        
    }
    
    func setupWithConstraints(to view: UIView, tableView: UITableView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        bottomConstraint.constant = 300
        bottomConstraint.isActive = true
        
        self.superview?.bringSubviewToFront(self)
        self.tableView = tableView
        
        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 0)
        tableViewBottomConstraint.isActive = true
        
    }
    
    func animate(completion: @escaping (Bool) -> Void) {
        
        bottomConstraint.constant = 0
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [.curveEaseInOut, .preferredFramesPerSecond30], animations: {
            
            self.layoutIfNeeded()
            
        }) { (true) in
            self.tableView.layoutIfNeeded()
            self.showPurchaseAndRestoreButtons()
            completion(true)
        }
    }
    
    private func showPurchaseAndRestoreButtons() {
        
        purchaseFullAccessButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        purchaseFullAccessButton.isHidden = false
        
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.6, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: [.curveEaseIn], animations: {
                
                self.purchaseFullAccessButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }) { (true) in
                
                self.restorePurchaseButton.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.restorePurchaseButton.isHidden = false
                
                UIView.animate(withDuration: 0.4, delay: 2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [.curveEaseOut], animations: {
                    
                    self.restorePurchaseButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                    
                })
                
            }
        }
        
    }
    
    private func startIndicatorAnimation(for button: UIButton) {
        purchaseIndicator.indicator(for: button)
        purchaseIndicator.startAnimating()
    }
    
    @IBAction func purchaseFullAccess(_ sender: UIButton) {
        
        startIndicatorAnimation(for: sender)
        
        iapBrain.purchase(productID: InAppPurchaseBrain.shared.iap_id)
        iapBrain.finishedLoadingPayment = { success in
            
            sender.setTitle(purchaseButtonTitle, for: .normal)
            self.purchaseIndicator.stopAnimating()
            
        }
    }
    
    @IBAction func restoreFullAccess(_ sender: UIButton) {
        iapBrain.restorePurchases()
    }

    
}

