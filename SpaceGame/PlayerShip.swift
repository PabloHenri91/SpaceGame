//
//  PlayerShip.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/22/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class PlayerShip: Control {
    
    var speedAtribute:Int = 0
    var acceleration:Int = 0
    var agility:Int = 0
    var armor:Int = 0
    var shieldPower:Int = 0
    var shieldRecharge:Int = 0
    
    init(index:Int) {
        super.init()
        loadNewShip(index)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadNewShip(index:Int) {
        
        var players = Players()
        var playerType = players.playerTypes[index] as! PlayerType
        
        self.speedAtribute = playerType.speed
        self.acceleration = playerType.acceleration
        self.agility = playerType.agility
        self.armor = playerType.armor
        self.shieldPower = playerType.shieldPower
        self.shieldRecharge = playerType.shieldRecharge
        
        self.name = "player"
        Control.locations.addObject("player")
        self.sketchPosition = CGPoint(x: 665, y: 590)
        self.yAlign = .center
        self.xAlign = .center
        self.zPosition = Config.HUDZPosition/2
        
        let texture = SKTexture(imageNamed: "player" + index.description)
        let spriteNode = SKSpriteNode(texture: texture, color: nil, size: texture.size())
        spriteNode.name = "player"
        self.addChild(spriteNode)
    }
    
    func reloadNewShip(index:Int) {
        var players = Players()
        var playerType = players.playerTypes[index] as! PlayerType
        
        self.speedAtribute = playerType.speed
        self.acceleration = playerType.acceleration
        self.agility = playerType.agility
        self.armor = playerType.armor
        self.shieldPower = playerType.shieldPower
        self.shieldRecharge = playerType.shieldRecharge
        
        (self.childNodeWithName("player"))!.removeFromParent()
        
        let texture = SKTexture(imageNamed: "player" + index.description)
        let spriteNode = SKSpriteNode(texture: texture, color: nil, size: texture.size())
        spriteNode.name = "player"
        spriteNode.zPosition = Config.HUDZPosition/2
        self.addChild(spriteNode)
    }
}

class PlayerType: NSObject {
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

class Players: NSObject {
    var playerTypes:NSMutableArray = NSMutableArray()
    
    override init() {
        //Futuramente vao ser predefinidos os valores de cada tipo inicial de nave
        for(var i = 0; i <= Config.playerTypesCount; i++){
            playerTypes.addObject(PlayerType(
                speed: Int(arc4random_uniform(90) + 10),
                acceleration: Int(arc4random_uniform(90) + 10),
                agility: Int(arc4random_uniform(90) + 10),
                armor: Int(arc4random_uniform(90) + 10),
                shieldPower: Int(arc4random_uniform(90) + 10),
                shieldRecharge: Int(arc4random_uniform(90) + 10)))
        }
    }
}