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
    
    
    //Física
    static func angularImpulse(agility:Int) -> CGFloat{
        return CGFloat((Double(agility - 10)/90) * (0.01 - 0.001) + 0.001)
    }
    
    static func maxAngularVelocity(agility:Int) -> CGFloat{
        return CGFloat((Double(agility - 10)/90) * (M_PI*2 - M_PI/2) + M_PI/2)
    }
    
    static func maxLinearVelocity(speedAtribute:Int) -> CGFloat{
        return CGFloat((Double(speedAtribute - 10)/90) * (2000 - 100) + 100)
    }
    
    static func force(acceleration:Int) -> CGFloat{
        return CGFloat((Double(acceleration - 10)/90) * (1000 - 100) + 100)
    }
}

public extension Int {
    /**
    Returns a random integer between 0 and n-1.
    */
    public static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    /**
    Create a random num Int
    :param: lower number Int
    :param: upper number Int
    :return: random number Int
    */
    public static func random(#min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    
    /**
    Create a random num Int
    :param: lower number CGFloat
    :param: upper number CGFloat
    :return: random number Int
    */
    public static func random(#min: CGFloat, max: CGFloat) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + Int(min)
    }
}

public extension Double {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    */
    public static func random() -> Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    /**
    Create a random num Double
    :param: lower number Double
    :param: upper number Double
    :return: random number Double
    */
    public static func random(#min: Double, max: Double) -> Double {
        return Double.random() * (max - min) + min
    }
}

public extension Float {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    */
    public static func random() -> Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    /**
    Create a random num Float
    :param: lower number Float
    :param: upper number Float
    :return: random number Float
    */
    public static func random(#min: Float, max: Float) -> Float {
        return Float.random() * (max - min) + min
    }
}

public extension CGFloat {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    */
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    public static func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}
