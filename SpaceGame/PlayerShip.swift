//
//  PlayerShip.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/22/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class PlayerShip: Control {
    
    var type:Int = 0
    var level:Int = 0
    
    var speedAtribute:Int = 0
    var acceleration:Int = 0
    var agility:Int = 0
    var armor:Int = 0
    var shieldPower:Int = 0
    var shieldRecharge:Int = 0
    
    init(index:Int, x:Int, y:Int) {
        super.init()
        loadNewShip(index, x: x, y: y)
    }
    
    init(playerShipData:PlayerShipData, x:Int, y:Int) {
        super.init()
        loadNewShip(Int(playerShipData.shopIndex), x: x, y: y)
        
        self.level = Int(playerShipData.level)
        
        self.speedAtribute += Int(playerShipData.bonusSpeed)
        self.acceleration += Int(playerShipData.bonusAcceleration)
        self.agility += Int(playerShipData.bonusAgility)
        self.armor += Int(playerShipData.bonusArmor)
        self.shieldPower += Int(playerShipData.bonusShieldPower)
        self.shieldRecharge += Int(playerShipData.bonusShieldRecharge)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadNewShip(index:Int, x:Int, y:Int) {
        
        var playerType = PlayerShips.types[index] as! PlayerShipType
        
        self.type = index
        self.level = 1
        
        self.speedAtribute = playerType.speed
        self.acceleration = playerType.acceleration
        self.agility = playerType.agility
        self.armor = playerType.armor
        self.shieldPower = playerType.shieldPower
        self.shieldRecharge = playerType.shieldRecharge
        
        self.name = "player"
        Control.locations.addObject("player")
        self.sketchPosition = CGPoint(x: x, y: y)
        self.yAlign = .center
        self.xAlign = .center
        self.zPosition = Config.HUDZPosition
        
        let texture = SKTexture(imageNamed: "player" + index.description)
        let spriteNode = SKSpriteNode(texture: texture, color: nil, size: texture.size())
        spriteNode.name = "player"
        self.addChild(spriteNode)
    }
    
    func reloadNewShip(index:Int) {
        var playerShipType = PlayerShips.types[index] as! PlayerShipType
        
        self.speedAtribute = playerShipType.speed
        self.acceleration = playerShipType.acceleration
        self.agility = playerShipType.agility
        self.armor = playerShipType.armor
        self.shieldPower = playerShipType.shieldPower
        self.shieldRecharge = playerShipType.shieldRecharge
        
        (self.childNodeWithName("player"))!.removeFromParent()
        
        let texture = SKTexture(imageNamed: "player" + index.description)
        let spriteNode = SKSpriteNode(texture: texture, color: nil, size: texture.size())
        spriteNode.name = "player"
        spriteNode.zPosition = Config.HUDZPosition/2
        self.addChild(spriteNode)
    }
    
    func updatePlayerDataCurrentPlayerShip() {
        var currentPlayerShip = GameViewController.memoryCard.playerData.currentPlayerShip
        var playerShipType = PlayerShips.types[self.type] as! PlayerShipType
        
        currentPlayerShip.level = self.level
        
        currentPlayerShip.bonusSpeed = self.speedAtribute - playerShipType.speed
        currentPlayerShip.bonusAcceleration = self.acceleration - playerShipType.acceleration
        currentPlayerShip.bonusAgility = self.agility - playerShipType.agility
        currentPlayerShip.bonusArmor = self.armor - playerShipType.armor
        currentPlayerShip.bonusShieldPower = self.shieldPower - playerShipType.shieldPower
        currentPlayerShip.bonusShieldRecharge = self.shieldRecharge - playerShipType.shieldRecharge
    }
}

class PlayerShipType: NSObject {
    var speed:Int
    var acceleration:Int
    var agility:Int
    var armor:Int
    var shieldPower:Int
    var shieldRecharge:Int
    
    init(speed:Int, acceleration:Int, agility:Int, armor:Int, shieldPower:Int, shieldRecharge:Int) {
        self.speed = speed
        self.acceleration = acceleration
        self.agility = agility
        self.armor = armor
        self.shieldPower = shieldPower
        self.shieldRecharge = shieldRecharge
    }
}

class PlayerShips: NSObject {
    static var types:NSArray = NSArray(array: [
        PlayerShipType(speed: 70, acceleration: 10, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 10), //0
        PlayerShipType(speed: 40, acceleration: 10, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 40), //1
        PlayerShipType(speed: 10, acceleration: 70, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 10), //2
        PlayerShipType(speed: 10, acceleration: 10, agility: 10, armor: 10, shieldPower: 40, shieldRecharge: 40), //3
        PlayerShipType(speed: 10, acceleration: 10, agility: 70, armor: 10, shieldPower: 10, shieldRecharge: 10), //4
        PlayerShipType(speed: 10, acceleration: 10, agility: 10, armor: 40, shieldPower: 40, shieldRecharge: 10), //5
        PlayerShipType(speed: 10, acceleration: 10, agility: 10, armor: 70, shieldPower: 10, shieldRecharge: 10), //6
        PlayerShipType(speed: 10, acceleration: 10, agility: 40, armor: 40, shieldPower: 10, shieldRecharge: 10), //7
        PlayerShipType(speed: 10, acceleration: 10, agility: 10, armor: 10, shieldPower: 70, shieldRecharge: 10), //8
        PlayerShipType(speed: 10, acceleration: 40, agility: 40, armor: 10, shieldPower: 10, shieldRecharge: 10), //9
        PlayerShipType(speed: 10, acceleration: 10, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 70), //10
        PlayerShipType(speed: 40, acceleration: 40, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 10), //11
        PlayerShipType(speed: 20, acceleration: 20, agility: 20, armor: 20, shieldPower: 20, shieldRecharge: 20)  //12
        ])
}