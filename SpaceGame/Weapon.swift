//
//  Weapon.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 7/6/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit

class Weapon: NSObject {
    
    var type:Int = 0
    var bonusAmmoPerMag: Int = 0
    var bonusDemage: Int = 0
    var bonusReloadTime: Int = 0
    
    init(weaponData:WeaponData) {
        self.type = Int(weaponData.shopIndex)
        self.bonusAmmoPerMag = Int(weaponData.bonusAmmoPerMag)
        self.bonusDemage = Int(weaponData.bonusDemage)
        self.bonusReloadTime = Int(weaponData.bonusReloadTime)
    }
}
