//
//  GameMath.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/11/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit

class GameMath: NSObject {
    
    static func requiredPoints(level:Int) -> Int{
        return 1000 * (level + 1)
    }
    
    static func maximumUP(level:Int) -> Int{
        return level * 3
    }
    
    static func currentUP(ship:Ship) -> Int {
        var shipType = Ships.types[ship.type] as! ShipType
        
        var totalBaseAtributePoints:Int = 0
        totalBaseAtributePoints += shipType.speed
        totalBaseAtributePoints += shipType.acceleration
        totalBaseAtributePoints += shipType.agility
        totalBaseAtributePoints += shipType.armor
        totalBaseAtributePoints += shipType.shieldPower
        totalBaseAtributePoints += shipType.shieldRecharge
        
        var totalAtributePoints:Int = 0
        totalAtributePoints += Int(ship.speedAtribute)
        totalAtributePoints += Int(ship.acceleration)
        totalAtributePoints += Int(ship.agility)
        totalAtributePoints += Int(ship.armor)
        totalAtributePoints += Int(ship.shieldPower)
        totalAtributePoints += Int(ship.shieldRecharge)
        
        return totalAtributePoints - totalBaseAtributePoints
    }
    
    static func availableUP(playerShip:PlayerShip) -> Int {
        return GameMath.maximumUP(playerShip.level) - GameMath.currentUP(playerShip)
    }
}
