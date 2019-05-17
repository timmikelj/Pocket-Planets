//
//  OfferList.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import Foundation

class OfferList {
    
    private let offers: [Offer] = [
        
        Offer(offerText: "See \(PlanetData.freePlanetNames()) in AR.", offerType: .free),
        Offer(offerText: "See all planets included in free access.", offerType: .fullAccess),
        Offer(offerText: "See \(PlanetData.fullAccessPlanetNames()) in AR.", offerType: .fullAccess),
        Offer(offerText: "Take photos of planets in real world and save them to your photo library.", offerType: .fullAccess)
    
    ]
    
    func freeOffers() -> [Offer]? {
        
        var freeOffers = [Offer]()
        
        for offer in offers {
            
            if offer.offerType == IAPOfferType.free {
                freeOffers.append(offer)
            }
            
        }
        
        return freeOffers
        
    }
    
    func fullAccessOffers() -> [Offer]? {
        
        var fullAccessOffers = [Offer]()
        
        for offer in offers {
            
            if offer.offerType == IAPOfferType.fullAccess {
                fullAccessOffers.append(offer)
            }
            
        }
        
        return fullAccessOffers
        
    }
}
