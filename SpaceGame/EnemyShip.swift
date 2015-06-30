//
//  EnemyShip.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/26/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//
//

import SpriteKit

class EnemyShip: Ship {
    
    ///Inicializa nave com e física opcional.
    init(level:Int, playerShip:PlayerShip, loadPhysics:Bool) {
        super.init()
        
        let shipType:Int = Int(arc4random_uniform(UInt32(Config.playerTypesCount)))
        
        let x:Int = Int(playerShip.position.x) + Int(arc4random_uniform(UInt32(Config.sceneSize().width * 1 - Config.sceneSize().width * 1))) + Int(Config.sceneSize().width * 1)
        
        let y = Int(playerShip.position.y) + Int(arc4random_uniform(UInt32(Config.sceneSize().height * 1 - Config.sceneSize().height * 1))) + Int(Config.sceneSize().height * 1)
        
        println(x.description + " " + y.description)
        self.loadNewShip(shipType, name:"player", x: x, y: y, loadPhysics:loadPhysics)
        
        self.level = Int(arc4random_uniform(UInt32(level)))
        
        self.speedAtribute += Int(0)
        self.acceleration += Int(0)
        self.agility += Int(0)
        self.armor += Int(0)
        self.shieldPower += Int(0)
        self.shieldRecharge += Int(0)
        
        if(loadPhysics) {
            self.angularImpulse = GameMath.angularImpulse(self.agility)
            self.maxAngularVelocity = GameMath.maxAngularVelocity(self.agility)
            self.maxLinearVelocity = GameMath.maxLinearVelocity(self.speedAtribute)
            self.force = GameMath.force(self.acceleration)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: NSTimeInterval) {
    
    }
}
