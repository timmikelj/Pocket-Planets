//
//  InAppPurchaseViewController.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

private let tableViewHeaderHeight: CGFloat = 40



class InAppPurchaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "InAppPurchaseViewController"

    @IBOutlet var inAppPurchasesTitleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var purchaseFullAccessButton: UIButton!
    @IBOutlet var restorePurchaseButton: UIButton!
    
    private let offerList = OfferList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: IAPTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: IAPTableViewCell.identifier)
        
        purchaseFullAccessButton.layer.cornerRadius = 8
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
            return cell
            
        } else {
            
            cell.offerLabel.text = offerList.fullAccessOffers()?[indexPath.row].offerText ?? ""
            return cell
            
        }
        
    }
    
    @IBAction func purchaseFullAccess(_ sender: UIButton) {
        
    }
    
    @IBAction func restoreFullAccess(_ sender: UIButton) {
        
    }
}
