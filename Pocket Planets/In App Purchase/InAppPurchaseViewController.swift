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

class InAppPurchaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "InAppPurchaseViewController"

    @IBOutlet var tableView: UITableView!
    
    private let offerList = OfferList()
    private let iapView = CustomIAPView()
    private let iapBrain = InAppPurchaseBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: IAPTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: IAPTableViewCell.identifier)
        
        iapBrain.fetchInAppPurchases()
        
        iapBrain.IAPLoaded = { success in
            
            if success {
                
                self.loadIAPPrice()
            }
            
        }
        
        iapView.setup(withConstraintsTo: self.view, tableView: tableView, iapBrain: iapBrain)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
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
    
    private func loadIAPPrice() {
        
        for product in iapBrain.products {
            
            if product.key == iapBrain.iap_id {
                
                if let currency = product.value.priceLocale.currencyCode {
                    
                    iapView.priceLabel.text = "\(product.value.price) \(currency)"
                    
                    iapView.animate { (true) in
                        //
                    }
                    
                }
            }
        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = ppBackgroundColor
        tableView.backgroundColor = ppBackgroundColor
        
    }
    
}
