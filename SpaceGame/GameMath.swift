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
        return 100 * (level + 1)
    }
    
    static func maximumUP(level:Int) -> Int{
        return level * 3
    }
    
    static func currentUP(playerShip:PlayerShip) -> Int {
        var playerType = PlayerShips.types[playerShip.type] as! PlayerShipType
        
        var totalBaseAtributePoints:Int = 0
        totalBaseAtributePoints += playerType.speed
        totalBaseAtributePoints += playerType.acceleration
        totalBaseAtributePoints += playerType.agility
        totalBaseAtributePoints += playerType.armor
        totalBaseAtributePoints += playerType.shieldPower
        totalBaseAtributePoints += playerType.shieldRecharge
        
        var totalAtributePoints:Int = 0
        totalAtributePoints += Int(playerShip.speedAtribute)
        totalAtributePoints += Int(playerShip.acceleration)
        totalAtributePoints += Int(playerShip.agility)
        totalAtributePoints += Int(playerShip.armor)
        totalAtributePoints += Int(playerShip.shieldPower)
        totalAtributePoints += Int(playerShip.shieldRecharge)
        
        return totalAtributePoints - totalBaseAtributePoints
    }
    
    static func availableUP(playerShip:PlayerShip) -> Int {
        return GameMath.maximumUP(playerShip.level) - GameMath.currentUP(playerShip)
    }
}
