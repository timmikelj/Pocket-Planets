//
//  UserDefaults.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import Foundation

private let firstAppLaunchKey = "isFirstAppLaunch"
private let appFullAccessKey = "full_access_iap"
private let darkModeKey = "dark_mode"
private let unitSystemKey = "unit_system"

final class UserDef {
    
    static func isFirstAppLaunch() -> Bool {
       return UserDefaults.standard.bool(forKey: firstAppLaunchKey)
    }
    
    static func firstAppLaunch() {
        UserDefaults.standard.set(true, forKey: firstAppLaunchKey)
    }
    
    static func isDarkMode() -> Bool {
        return UserDefaults.standard.bool(forKey: darkModeKey)
    }
    
    static func darkModeApplied(_ isDarkMode: Bool) {
        UserDefaults.standard.set(isDarkMode, forKey: darkModeKey)
    }
    
    static func changeUnitSystem(to unit: DistanceUnit) {
        UserDefaults.standard.set(unit.name, forKey: unitSystemKey)
    }
    
    static func currentDistanceUnit() -> DistanceUnit {
        
        if let currentUnitName = UserDefaults.standard.object(forKey: unitSystemKey) as? String {
            
            switch currentUnitName {
                
                case UnitType.defaultUnit.rawValue:
                    return units[0]
                
                case UnitType.metric.rawValue:
                    return units[1]
                
                case UnitType.imperial.rawValue:
                    return units[2]
                
                default:
                    return units[0]
                
            }
            
        }
        
        return units[0]
    }
    
}
