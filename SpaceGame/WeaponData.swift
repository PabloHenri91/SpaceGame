//
//  WeaponData.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/10/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import Foundation
import CoreData

@objc(WeaponData)

class WeaponData: NSManagedObject {

    @NSManaged var bonusAmmoPerMag: NSNumber
    @NSManaged var bonusDemage: NSNumber
    @NSManaged var bonusReloadTime: NSNumber
    @NSManaged var shopIndex: NSNumber
    @NSManaged var hardPoint: HardPointData
    @NSManaged var player: PlayerData

}
