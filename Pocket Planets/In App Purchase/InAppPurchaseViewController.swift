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
    @IBOutlet var purchaseFullAccessButton: UIButton!
    @IBOutlet var restorePurchaseButton: UIButton!
    @IBOutlet var priceLabel: UILabel!
    
    private let offerList = OfferList()
    private let iapBrain = InAppPurchaseBrain()
    private let purchaseIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchaseFullAccessButton.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: IAPTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: IAPTableViewCell.identifier)
        
        purchaseFullAccessButton.layer.cornerRadius = 8
        
        InAppPurchaseBrain.shared.fetchInAppPurchases()
        
        InAppPurchaseBrain.shared.IAPLoaded = { success in
            
            if success {
                
                self.purchaseFullAccessButton.isHidden = false
                self.loadIAPPrice()
            }
            
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadUI()
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
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
                    purchaseFullAccessButton.isHidden = false
                    
                }
            }
        }
        
    }
    
    private func loadUI() {
        
        view.backgroundColor = ppBackgroundColor
        tableView.backgroundColor = ppBackgroundColor
        
        purchaseFullAccessButton.backgroundColor = ppTextColor
        purchaseFullAccessButton.setTitleColor(ppBackgroundColor, for: .normal)
        restorePurchaseButton.setTitleColor(ppTextColor, for: .normal)
        priceLabel.textColor = ppTextColor
        
    }

    func startIndicatorAnimation(for button: UIButton) {
        purchaseIndicator.indicator(for: button)
        purchaseIndicator.startAnimating()
    }
    
}
