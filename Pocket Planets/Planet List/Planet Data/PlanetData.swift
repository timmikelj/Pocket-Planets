//
//  planetData.swift
//  AR Planets
//
//  Created by Tim Mikelj on 25/02/2018.
//  Copyright © 2018 Tim Mikelj. All rights reserved.
//

import UIKit

class PlanetData {

//    static let planetPatternArray = ["mercury.jpg", "venus.jpg", "earth_day.jpg", "mars.jpg", "jupiter.jpg", "saturn.jpg", "uranus.jpg", "neptune.jpg"]
    
    static let planets: [Planet] = [
        
        Planet(name: "Mercury",
               distanceFromSun: 58,
               diameterInKm: 3031,
               image: UIImage(named: "mercury") ?? UIImage(),
               patternImageName: "mercury.jpg"),
        
        Planet(name: "Venus",
               distanceFromSun: 67,
               diameterInKm: 7521,
               image: UIImage(named: "venus") ?? UIImage(),
               patternImageName: "venus.jpg"),
        
        Planet(name: "Earth",
               distanceFromSun: 93,
               diameterInKm: 7926,
               image: UIImage(named: "earth") ?? UIImage(),
               patternImageName: "earth_day.jpg"),
        
        Planet(name: "Mars",
               distanceFromSun: 142,
               diameterInKm: 4222,
               image: UIImage(named: "mars") ?? UIImage(),
               patternImageName: "mars.jpg"),
        
        Planet(name: "Jupiter",
               distanceFromSun: 484,
               diameterInKm: 88846,
               image: UIImage(named: "jupiter") ?? UIImage(),
               patternImageName: "jupiter.jpg"),
        
        Planet(name: "Saturn",
               distanceFromSun: 887,
               diameterInKm: 74900,
               image: UIImage(named: "saturn") ?? UIImage(),
               patternImageName: "saturn.jpg"),
        
        Planet(name: "Uranus",
               distanceFromSun: 1784,
               diameterInKm: 31763,
               image: UIImage(named: "uranus") ?? UIImage(),
               patternImageName: "uranus.jpg"),
        
        Planet(name: "Neptune",
               distanceFromSun: 2794,
               diameterInKm: 30779,
               image: UIImage(named: "neptune") ?? UIImage(),
               patternImageName: "neptune.jpg")
        
    ]
}
