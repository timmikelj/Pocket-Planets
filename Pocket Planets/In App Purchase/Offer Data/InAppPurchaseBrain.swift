//
//  InAppPurchaseBrain.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit
import StoreKit

private let thankYouMessage = "Thank you for purchasing full access of Pocket Planets, enjoy the app! \n \nLots of love, Pocket Planets Team"
private let failedMessage = "Thank you for trying to purchase the full access of Pocket Planets, however there has been an error. Please try again."
private let restoredMessage = "You have successfully restored full access to Pocket Planets, enjoy the app! \n \nLots of love, Pocket Planets Team"

class InAppPurchaseBrain: NSObject {
    
    static var shared = InAppPurchaseBrain()
    
    let iap_id = "pocket_planets_full_access"
    var products: [String: SKProduct] = [:]
    var IAPLoaded: ((_ completed: Bool) -> Void)? = nil
    
    func fetchInAppPurchases() {
        let productIDs = Set([iap_id])
        let request = SKProductsRequest(productIdentifiers: productIDs)
        request.delegate = self
        request.start()
    }
    
    func purchase(productID: String) {
        
        if SKPaymentQueue.canMakePayments() {
            
            if let product = products[productID] {
                let payment = SKPayment(product: product)
                SKPaymentQueue.default().add(payment)
            }
        }
    }
    
    func restorePurchases() {
        if SKPaymentQueue.canMakePayments() {
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
}

extension InAppPurchaseBrain: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        response.invalidProductIdentifiers.forEach { product in
            print("Invalid: \(product)")
        }
        
        response.products.forEach { product in
            print("Valid: \(product)")
            products[product.productIdentifier] = product
        }
        
        IAPLoaded!(true)
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        showErrorMessage(error: error.localizedDescription)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                    
                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    showThankYouMessage()
                    break
                    
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    showFailedMessage()
                    break
                    
                case .restored:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    
                    showRestoredMessage()
                    break
                    
                default: break
                    
                }
            }
        }
    }
    
    private func showThankYouMessage() {
        UIAlertController().showOneButtonAlert(title: "You Are Awesome!", buttonTitle: "Close", message: thankYouMessage)
    }
    
    private func showFailedMessage() {
        UIAlertController().showOneButtonAlert(title: "Error", buttonTitle: "Close", message: failedMessage)
    }
    
    private func showRestoredMessage() {
        UIAlertController().showOneButtonAlert(title: "Great to have you back!", buttonTitle: "Close", message: restoredMessage)
    }
    
    private func showErrorMessage(error: String) {
        UIAlertController().showOneButtonAlert(title: "Error", buttonTitle: "Close", message: error)
    }

}
