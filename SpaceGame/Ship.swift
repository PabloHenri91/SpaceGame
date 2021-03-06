//
//  Ship.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/26/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class Ship: Control {
    
    var type:Int = 0
    var level:Int = 0
    
    var speedAtribute:Int = 0
    var acceleration:Int = 0
    var agility:Int = 0
    var armor:Int = 0
    var shieldPower:Int = 0
    var shieldRecharge:Int = 0
    
    //Movimentação
    var needToMove:Bool = false
    var destination:CGPoint = CGPoint.zero
    var rotation:CGFloat = 0
    var totalRotation:CGFloat = 0
    var startMoving:Double = 0
    
    //Física
    var angularImpulse:CGFloat = 0
    var maxAngularVelocity:CGFloat = 0
    var maxLinearVelocity:CGFloat = 0
    var force:CGFloat = 0
    
    func loadPhysics(texture:SKTexture){
        //Physics Config
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: texture.size().width * 0.9, height: texture.size().height * 0.9))
        self.physicsBody!.angularDamping = 10
        self.physicsBody!.linearDamping = 5
    }
    
    override init() {
        super.init()
        //Este inicializador deve ser sobreescrito nas subclasses
    }
    
    init(index:Int, name:String = "", x:Int, y:Int) {
        super.init()
        loadNewShip(index, name:name, x: x, y: y, loadPhysics:false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setRotationToPoint(point:CGPoint) {
        self.rotation = CGFloat(M_PI) + CGFloat(-atan2f(Float(self.position.x - point.x), Float(self.position.y - point.y)))
    }
    
    func loadNewShip(index:Int, name:String, x:Int, y:Int, loadPhysics:Bool) {
        
        var shipType = Ships.types[index] as! ShipType
        
        self.type = index
        self.level = 1
        
        self.speedAtribute = shipType.speed
        self.acceleration = shipType.acceleration
        self.agility = shipType.agility
        self.armor = shipType.armor
        self.shieldPower = shipType.shieldPower
        self.shieldRecharge = shipType.shieldRecharge
        
        self.name = name
        
        self.zPosition = Config.HUDZPosition
        
        let texture = SKTexture(imageNamed: "ship" + index.description)
        let spriteNode = SKSpriteNode(texture: texture, color: UIColor.clearColor(), size: texture.size())
        spriteNode.name = "ship"
        
        if(loadPhysics){
            self.position = CGPoint(x: x, y: y)
            self.loadPhysics(texture)
        } else {
            self.sketchPosition = CGPoint(x: x, y: y)
            self.yAlign = .center
            self.xAlign = .center
            Control.locations.addObject(name)
        }
        
        self.addChild(spriteNode)
    }
    
    func reloadNewShip(index:Int) {
        var shipType = Ships.types[index] as! ShipType
        
        self.speedAtribute = shipType.speed
        self.acceleration = shipType.acceleration
        self.agility = shipType.agility
        self.armor = shipType.armor
        self.shieldPower = shipType.shieldPower
        self.shieldRecharge = shipType.shieldRecharge
        
        (self.childNodeWithName("ship"))!.removeFromParent()
        
        let texture = SKTexture(imageNamed: "ship" + index.description)
        let spriteNode = SKSpriteNode(texture: texture, color: UIColor.clearColor(), size: texture.size())
        spriteNode.name = "ship"
        spriteNode.zPosition = Config.HUDZPosition/2
        self.addChild(spriteNode)
    }
}

class ShipType: NSObject {
    var speed:Int
    var acceleration:Int
    var agility:Int
    var armor:Int
    var shieldPower:Int
    var shieldRecharge:Int
    var price:Int
    
    init(speed:Int, acceleration:Int, agility:Int, armor:Int, shieldPower:Int, shieldRecharge:Int, price:Int) {
        self.speed = speed
        self.acceleration = acceleration
        self.agility = agility
        self.armor = armor
        self.shieldPower = shieldPower
        self.shieldRecharge = shieldRecharge
        self.price = price
    }
}

class Ships: NSObject {
    static var types:NSArray = NSArray(array: [
        ShipType(speed: 70, acceleration: 10, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 10, price:1000), //0
        ShipType(speed: 40, acceleration: 10, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 40, price:2000), //1
        ShipType(speed: 10, acceleration: 70, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 10, price:3000), //2
        ShipType(speed: 10, acceleration: 10, agility: 10, armor: 10, shieldPower: 40, shieldRecharge: 40, price:4000), //3
        ShipType(speed: 10, acceleration: 10, agility: 70, armor: 10, shieldPower: 10, shieldRecharge: 10, price:5000), //4
        ShipType(speed: 10, acceleration: 10, agility: 10, armor: 40, shieldPower: 40, shieldRecharge: 10, price:6000), //5
        ShipType(speed: 10, acceleration: 10, agility: 10, armor: 70, shieldPower: 10, shieldRecharge: 10, price:7000), //6
        ShipType(speed: 10, acceleration: 10, agility: 40, armor: 40, shieldPower: 10, shieldRecharge: 10, price:8000), //7
        ShipType(speed: 10, acceleration: 10, agility: 10, armor: 10, shieldPower: 70, shieldRecharge: 10, price:9000), //8
        ShipType(speed: 10, acceleration: 40, agility: 40, armor: 10, shieldPower: 10, shieldRecharge: 10, price:10000), //9
        ShipType(speed: 10, acceleration: 10, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 70, price:11000), //10
        ShipType(speed: 40, acceleration: 40, agility: 10, armor: 10, shieldPower: 10, shieldRecharge: 10, price:12000), //11
        ShipType(speed: 20, acceleration: 20, agility: 20, armor: 20, shieldPower: 20, shieldRecharge: 20, price:13000)  //12
        ])
}
