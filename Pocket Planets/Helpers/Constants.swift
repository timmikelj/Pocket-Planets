//
//  Constants.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import UIKit

let appTitle = "Pocket Planets"
let cameraButtonName = "button static"
let cameraButtonSelectedName = "button pressed"
let fullAccessLayerImageName = "full access layer"
let tickImageName = "tick"
let tickDarkModeImageName = "tick_darkmode"

enum UnitType: String {
    case defaultUnit = "Defaults"
    case metric = "Metric"
    case imperial = "Imperial"
}

struct DistanceUnit {
    
    let index: Int!
    let name: String
    
    init(index: Int, name: String) {
        self.index = index
        self.name = name
    }
    
}

let usesMetricSystem = NSLocale.current.usesMetricSystem
let kilometersPerMile: Double = 1.60934

/// Array of distance units
let units: [DistanceUnit] = [DistanceUnit(index: 0, name: UnitType.defaultUnit.rawValue),
                             DistanceUnit(index: 1, name: UnitType.metric.rawValue),
                             DistanceUnit(index: 2, name: UnitType.imperial.rawValue)]

public func systemDistanceUnit() -> String {
    
    let currentUnit = UserDef.currentDistanceUnit()
    
    switch currentUnit.name {

        case UnitType.defaultUnit.rawValue:

            if usesMetricSystem {
                return "kilometres"
            } else {
                return "miles"
            }

        case UnitType.metric.rawValue:
            return "kilometres"

        case UnitType.imperial.rawValue:
            return "miles"

        default:
            return ""
    }

}
