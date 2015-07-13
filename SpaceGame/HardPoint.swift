//
//  HardPoint.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/30/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit

enum positions {
    case leftFront
    case leftRear
    case centerRear
    case centerFront
    case rightRear
    case rightFront
}

class HardPoint: NSObject {
    
    var isEmpty:Bool = true
    var weapon:Weapon?
    var position:positions = .centerFront
    
    init(hardPointData:HardPointData) {
        self.isEmpty = (hardPointData.weapon == nil)
        
        if (!self.isEmpty) {
            self.weapon = Weapon(weaponData:hardPointData.weapon!)
        }
    }
    
}
