//
//  InAppPurchaseViewController.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

class InAppPurchaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "InAppPurchaseViewController"

    @IBOutlet var inAppPurchasesTitleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    private var offers = [Offer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        offers = OfferList.offers
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return IAPOfferType.allCases.count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: IAPTableViewCell.identifier) as! IAPTableViewCell
        cell.offerLabel.text = offers[indexPath.row].offerText
        
        return cell
    }
    
    @IBAction func purchaseFullAccess(_ sender: UIButton) {
        
    }
    
    @IBAction func restoreFullAccess(_ sender: UIButton) {
        
    }
}
