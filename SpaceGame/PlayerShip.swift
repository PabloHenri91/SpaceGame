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
        super.init(name: "player", textureName: "player\(index)", x: 601, y: 526, align:.center)
        //Dados vao vir do save do jogo ou vao ser carregados quando o jogador criar uma nova nave
        self.speedAtribute = 10
        self.acceleration = 10
        self.agility = 10
        self.armor = 10
        self.shieldPower = 10
        self.shieldRecharge = 10
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func load(){
        //Futuramente vao ser predefinidos os valores de cada tipo inicial de nave
        for(var i = 0; i < 6; i++){
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