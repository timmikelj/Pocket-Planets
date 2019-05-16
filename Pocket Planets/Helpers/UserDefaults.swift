//
//  UserDefaults.swift
//  Pocket Planets
//
//  Created by Tim Mikelj on 16/05/2019.
//  Copyright © 2019 Tim Mikelj. All rights reserved.
//

import Foundation

private let firstAppLaunchKey = "isFirstAppLaunch"

final class UserDef {
    
    static func isFirstAppLaunch() -> Bool {
       return UserDefaults.standard.bool(forKey: firstAppLaunchKey)
    }
    
    static func firstAppLaunch() {
        UserDefaults.standard.set(true, forKey: firstAppLaunchKey)
    }
    
}
