//
//  Offer.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import Foundation

struct Offer {
    
    let offerText: String?
    let offerType: IAPOfferType!
    
    init(offerText: String?, offerType: IAPOfferType) {
        self.offerText = offerText
        self.offerType = offerType
    }
    
}
