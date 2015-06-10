//
//  HardPointData.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/10/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import Foundation
import CoreData

@objc(HardPointData)

class HardPointData: NSManagedObject {

    @NSManaged var playerShip: PlayerShipData
    @NSManaged var weapon: WeaponData

}
