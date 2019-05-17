//
//  InAppPurchaseViewController.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

private let tableViewHeaderHeight: CGFloat = 50

class InAppPurchaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "InAppPurchaseViewController"

    @IBOutlet var tableView: UITableView!
    @IBOutlet var purchaseFullAccessButton: UIButton!
    @IBOutlet var restorePurchaseButton: UIButton!
    @IBOutlet var priceLabel: UILabel!
    
    private let offerList = OfferList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchaseFullAccessButton.isEnabled = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: IAPTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: IAPTableViewCell.identifier)
        
        purchaseFullAccessButton.layer.cornerRadius = 8
        
        InAppPurchaseBrain.shared.fetchInAppPurchases()
        
        InAppPurchaseBrain.shared.IAPLoaded = { success in
            
            if success { self.loadIAPPrice() }
            
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
         navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        navigationController?.navigationBar.prefersLargeTitles = true
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
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
            headerView.textLabel?.shadowColor = .gray
            headerView.textLabel?.textColor = ppTextColor
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
           
            return offerList.freeOffers()?.count ?? 0
            
        } else {
            
            return offerList.fullAccessOffers()?.count ?? 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: IAPTableViewCell.identifier) as! IAPTableViewCell
        
        if indexPath.section == 0 {

            cell.offerLabel.text = offerList.freeOffers()?[indexPath.row].offerText ?? ""
            
        } else {
            
            cell.offerLabel.text = offerList.fullAccessOffers()?[indexPath.row].offerText ?? ""
            
        }
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    @IBAction func purchaseFullAccess(_ sender: UIButton) {
        InAppPurchaseBrain.shared.purchase(productID: InAppPurchaseBrain.shared.iap_id)
    }
    
    @IBAction func restoreFullAccess(_ sender: UIButton) {
        InAppPurchaseBrain.shared.restorePurchases()
    }
    
    
    private func loadIAPPrice() {
        
        for product in InAppPurchaseBrain.shared.products {
            
            if product.key == InAppPurchaseBrain.shared.iap_id {
                
                if let currency = product.value.priceLocale.currencyCode {
                    
                    self.priceLabel.text = "\(product.value.price) \(currency)"
                    purchaseFullAccessButton.isEnabled = true
                    
                }
            }
        }
        
    }
    
}
