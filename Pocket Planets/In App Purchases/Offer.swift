//
//  Offer.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import Foundation

class Offer {
    
    var offerText: String!
    var offerType: IAPOfferType!
    
    convenience init(offerText: String, offerType: IAPOfferType) {
        self.init()
        self.offerText = offerText
        self.offerType = offerType
    }
    
}
