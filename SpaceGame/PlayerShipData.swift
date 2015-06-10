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

    @NSManaged var bunusAcceleration: NSNumber
    @NSManaged var bunusAgility: NSNumber
    @NSManaged var bunusArmor: NSNumber
    @NSManaged var bunusShieldPower: NSNumber
    @NSManaged var bunusShieldRecharge: NSNumber
    @NSManaged var bunusSpeed: NSNumber
    @NSManaged var level: NSNumber
    @NSManaged var shopIndex: NSNumber
    @NSManaged var hardPoints: NSSet
    @NSManaged var player: PlayerData

}
