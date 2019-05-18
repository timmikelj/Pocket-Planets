//
//  Double+Extensions.swift
//  Pocket Planets
//
//  Created by Tim on 17/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import Foundation

extension Double {
    
    func convertToUserFriendlyDistance() -> String {

        var outputDistance = Int()
        let currentUnit = UserDef.currentDistanceUnit()
        
        switch currentUnit.name {

            case UnitType.defaultUnit.rawValue:

                if usesMetricSystem {
                    outputDistance = Int(self * kilometersPerMile)
                } else {
                    outputDistance = Int(self)
                }

            case UnitType.metric.rawValue:

                outputDistance = Int(self * kilometersPerMile)

            case UnitType.imperial.rawValue:

                outputDistance = Int(self)

            default:
                outputDistance = 0
        }
        
        
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value:outputDistance)) ?? ""
        
    }
    
}
