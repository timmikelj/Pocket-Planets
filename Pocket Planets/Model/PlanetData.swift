//
//  planetData.swift
//  AR Planets
//
//  Created by Tim Mikelj on 25/02/2018.
//  Copyright © 2018 Tim Mikelj. All rights reserved.
//

import UIKit

class PlanetData {

    static let planetArray = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    static let planetPatternArray = ["mercury.jpg", "venus.jpg", "earth_day.jpg", "mars.jpg", "jupiter.jpg", "saturn.jpg", "uranus.jpg", "neptune.jpg"]

    let planetImagesArray : [UIImage] = [
        UIImage(named: "mercury")!,
        UIImage(named: "venus")!,
        UIImage(named: "earth")!,
        UIImage(named: "mars")!,
        UIImage(named: "jupiter")!,
        UIImage(named: "saturn")!,
        UIImage(named: "uranus")!,
        UIImage(named: "neptune")!
    ]

    let distanceFromSun : [Int] = [58, 67, 93, 142, 484, 887, 1784, 2794]

    let diameterInKm : [String] = ["3,031", "7,521", "7,926", "4,222", "88,846", "74,900", "31,763", "30,779"]

}
