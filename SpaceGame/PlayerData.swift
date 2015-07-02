//
//  PlayerData.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/10/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import Foundation
import CoreData

@objc(PlayerData)

class PlayerData: NSManagedObject {

    @NSManaged var score: NSNumber
    @NSManaged var playerShips: NSSet
    @NSManaged var weapons: NSSet
    @NSManaged var currentPlayerShip: PlayerShipData

}

extension PlayerData {
    func addPlayerShipObject(value: PlayerShipData) {
        var items = self.mutableSetValueForKey("playerShips");
        items.addObject(value)
    }
}
