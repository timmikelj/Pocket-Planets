//
//  Planet.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

struct Planet {
    
    var name: String!
    var distanceFromSun: Double! // in million miles
    var diameterInKm: Double!
    var type: IAPOfferType!
    var image: UIImage!
    var patternImageName: String!
    
    init(name: String, distanceFromSun: Double, diameterInKm: Double, type: IAPOfferType, image: UIImage, patternImageName: String) {
        self.name = name
        self.distanceFromSun = distanceFromSun
        self.diameterInKm = diameterInKm
        self.type = type
        self.image = image
        self.patternImageName = patternImageName
    }
    
}
