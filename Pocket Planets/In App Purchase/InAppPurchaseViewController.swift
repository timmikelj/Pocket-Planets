//
//  InAppPurchaseViewController.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

private let tableViewHeaderHeight: CGFloat = 60
private let headerViewFontSize: CGFloat = 20
private let purchaseButtonTitle = "Purchase Full Access"
private let restoredButtonTitle = "Restore Full Access"

class InAppPurchaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "InAppPurchaseViewController"

    @IBOutlet var tableView: UITableView!
    
    private let offerList = OfferList()
    private let iapBrain = InAppPurchaseBrain()
    private let purchaseIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: IAPTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: IAPTableViewCell.identifier)
        
        InAppPurchaseBrain.shared.fetchInAppPurchases()
        
        InAppPurchaseBrain.shared.IAPLoaded = { success in
            
            if success {
                
                self.loadIAPPrice()
            }
            
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUI()
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        animateUI { (true) in
//            //
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return IAPOfferType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return IAPOfferType.free.rawValue
        } else {
            return IAPOfferType.fullAccess.rawValue
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = ppBackgroundColor
            headerView.textLabel?.font = UIFont.systemFont(ofSize: headerViewFontSize, weight: .semibold)
            headerView.textLabel?.textColor = ppTextColor
            headerView.alpha = 0.95
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
           
            return offerList.freeOffers().count
            
        } else {
            
            return offerList.fullAccessOffers().count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: IAPTableViewCell.identifier) as! IAPTableViewCell
        
        if indexPath.section == 0 {
            
            cell.configureCell(with: offerList.freeOffers()[indexPath.row])
            
        } else {
            
            cell.configureCell(with: offerList.fullAccessOffers()[indexPath.row])
            
        }
        
        cell.selectionStyle = .none
        return cell
        
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
    
    
    private func loadIAPPrice() {
        
        for product in InAppPurchaseBrain.shared.products {
            
            if product.key == InAppPurchaseBrain.shared.iap_id {
                
                if let currency = product.value.priceLocale.currencyCode {
                    
                    self.priceLabel.text = "\(product.value.price) \(currency)"
                    
                    animateUI { (true) in
                        self.showPurchaseAndRestoreButtons()
                    }
                    
                }
            }
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
    
    private func setupUI() {
        
        IAPViewBottomConstraint.constant = -300
        
        purchaseFullAccessButton.isHidden = true
        restorePurchaseButton.isHidden = true
        
        purchaseFullAccessButton.layer.cornerRadius = 8
        
        self.IAPView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func loadUI() {
        
        view.backgroundColor = ppBackgroundColor
        tableView.backgroundColor = ppBackgroundColor
        
        IAPView.roundCorners([.topLeft, .topRight], radius: 20)
        
        if ppTextColor == .black {
            IAPView.backgroundColor = darkModeColor
        } else {
            IAPView.backgroundColor = ppTextColor
        }
        
        IAPView.layer.shadowColor = ppBackgroundColor.cgColor
        IAPView.layer.shadowOffset = CGSize(width: 0, height: -2)
        IAPView.layer.shadowRadius = 4
        
        purchaseFullAccessButton.backgroundColor = ppBackgroundColor
        purchaseFullAccessButton.setTitleColor(ppTextColor, for: .normal)
        restorePurchaseButton.setTitleColor(ppBackgroundColor, for: .normal)
        priceLabel.textColor = ppBackgroundColor
        
    }
    
    private func animateUI(completion: @escaping (Bool) -> Void) {

        IAPViewBottomConstraint.constant = 0
        tableViewBottomConstraint.constant = -IAPView.frame.height
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [.curveEaseInOut], animations: {
                
                self.IAPView.layoutIfNeeded()
                
            }) { (true) in
                self.tableView.layoutIfNeeded()
                completion(true)
            }
        }
    }

    private func startIndicatorAnimation(for button: UIButton) {
        purchaseIndicator.indicator(for: button)
        purchaseIndicator.startAnimating()
    }
    
    private func startIAPloadingIndicator() {
        
    }
    
}
