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
               type: .free,
               image: UIImage(named: "mercury") ?? UIImage(),
               patternImageName: "mercury.jpg"),
        
        Planet(name: "Venus",
               distanceFromSun: 67,
               diameterInKm: 7521,
               type: .free,
               image: UIImage(named: "venus") ?? UIImage(),
               patternImageName: "venus.jpg"),
        
        Planet(name: "Earth",
               distanceFromSun: 93,
               diameterInKm: 7926,
               type: .free,
               image: UIImage(named: "earth") ?? UIImage(),
               patternImageName: "earth_day.jpg"),
        
        Planet(name: "Mars",
               distanceFromSun: 142,
               diameterInKm: 4222,
               type: .fullAccess,
               image: UIImage(named: "mars") ?? UIImage(),
               patternImageName: "mars.jpg"),
        
        Planet(name: "Jupiter",
               distanceFromSun: 484,
               diameterInKm: 88846,
               type: .fullAccess,
               image: UIImage(named: "jupiter") ?? UIImage(),
               patternImageName: "jupiter.jpg"),
        
        Planet(name: "Saturn",
               distanceFromSun: 887,
               diameterInKm: 74900,
               type: .fullAccess,
               image: UIImage(named: "saturn") ?? UIImage(),
               patternImageName: "saturn.jpg"),
        
        Planet(name: "Uranus",
               distanceFromSun: 1784,
               diameterInKm: 31763,
               type: .fullAccess,
               image: UIImage(named: "uranus") ?? UIImage(),
               patternImageName: "uranus.jpg"),
        
        Planet(name: "Neptune",
               distanceFromSun: 2794,
               diameterInKm: 30779,
               type: .fullAccess,
               image: UIImage(named: "neptune") ?? UIImage(),
               patternImageName: "neptune.jpg")
        
    ]
    
    static func freePlanetNames() -> String {
        
        var names = String()
        for planet in planets {
            if planet.type == IAPOfferType.free {
                
                if !names.isEmpty { names.append(", ") }
                names.append("\(planet.name ?? "")")
                
            }
        }
        
        return names
        
    }
    
    static func fullAccessPlanetNames() -> String {
        
        var names = String()
        for planet in planets {
            if planet.type == IAPOfferType.fullAccess {
                
                if !names.isEmpty { names.append(", ") }
                names.append("\(planet.name ?? "") ")
                
            }
        }
        
        return names
        
    }
    
    static func freePlanets() -> [Planet]? {
        
        var returnPlanets: [Planet]!
        
        for planet in planets {
            if planet.type == IAPOfferType.free {
                returnPlanets.append(planet)
            }
        }
        
        return returnPlanets
        
    }

    static func fullAccessPlanet() -> [Planet] {
        
        var returnPlanets: [Planet]!
        
        for planet in planets {
            if planet.type == IAPOfferType.fullAccess {
                returnPlanets.append(planet)
            }
        }
        
        return returnPlanets
        
    }
}
