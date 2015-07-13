//
//  PlayerShipData.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/10/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import Foundation
import CoreData

@objc(PlayerShipData)

class PlayerShipData: NSManagedObject {

    @NSManaged var bonusAcceleration: NSNumber
    @NSManaged var bonusAgility: NSNumber
    @NSManaged var bonusArmor: NSNumber
    @NSManaged var bonusShieldPower: NSNumber
    @NSManaged var bonusShieldRecharge: NSNumber
    @NSManaged var bonusSpeed: NSNumber
    @NSManaged var level: NSNumber
    @NSManaged var shopIndex: NSNumber
    @NSManaged var hardPoints: NSSet
    @NSManaged var player: PlayerData

}

extension PlayerShipData {
    //Adiciona HardPointData no NSSet hardPoints
    func addHardPointObject(value: HardPointData) {
        var items = self.mutableSetValueForKey("hardPoints");
        items.addObject(value)
    }
}
