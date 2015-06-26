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
    
    //Movimentação
    var needToMove:Bool = false
    var destination:CGPoint = CGPoint.zeroPoint
    var rotation:CGFloat = 0
    var totalRotation:CGFloat = 0
    var startMoving:Double = 0
    
    //Toques
    var lastNoTouchTime:Double = 0
    var touchesArrayCount: Int = 0
    var lastTouchesArrayCount: Int = 0
    var firstTouchLocation:CGPoint = CGPoint.zeroPoint
    var lastTouchLocation:CGPoint = CGPoint.zeroPoint
    
    init(index:Int, x:Int, y:Int) {
        super.init()
        loadNewShip(index, x: x, y: y)
    }
    
    init(playerShipData:PlayerShipData, x:Int, y:Int, loadPhysics:Bool = false) {
        super.init()
        loadNewShip(Int(playerShipData.shopIndex), x: x, y: y, loadPhysics:loadPhysics)
        
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
    
    func update(currentTime: NSTimeInterval) {
        
        self.lastTouchesArrayCount = self.touchesArrayCount
        self.touchesArrayCount = Control.touchesArray.count
        
        switch(self.touchesArrayCount) {
            
            //Zero toques
        case 0:
            //Um toque curto
            if((self.lastTouchesArrayCount == 1) && currentTime - lastNoTouchTime < 1) {
                self.needToMove = true
                self.startMoving = currentTime
                self.destination = self.firstTouchLocation
            }
            self.lastNoTouchTime = currentTime
            
            if(self.needToMove){
                self.setRotationToPoint(self.destination)
            }
            
            break
            
            //Um toque
        case 1:
            self.firstTouchLocation = (Control.touchesArray[0] as! UITouch).locationInNode(self.parent)
            
            self.setRotationToPoint(self.firstTouchLocation)
            break
            
            //Mais de um toque
        default:
            
            self.firstTouchLocation = (Control.touchesArray[0] as! UITouch).locationInNode(self.parent)
            self.lastTouchLocation = (Control.touchesArray.lastObject as! UITouch).locationInNode(self.parent)
            
            self.needToMove = true
            self.startMoving = currentTime
            self.destination = lastTouchLocation
            
            self.setRotationToPoint(self.firstTouchLocation)
            
            break
        }
        
        if(currentTime - self.startMoving > 1){
            self.needToMove = false
        }
        
        if(abs(self.physicsBody!.angularVelocity) < CGFloat(M_PI * 2) && (self.needToMove || self.touchesArrayCount > 0)) {
            self.totalRotation = self.rotation - self.zRotation
            
            while(self.totalRotation < -CGFloat(M_PI)) { self.totalRotation += CGFloat(M_PI * 2) }
            while(self.totalRotation >  CGFloat(M_PI)) { self.totalRotation -= CGFloat(M_PI * 2) }
            
            self.physicsBody!.applyAngularImpulse(self.totalRotation *  0.005)
        }
        
        if (self.needToMove) {
            var dX:CGFloat = destination.x - self.position.x
            var dY:CGFloat = destination.y - self.position.y
            var distanceToDestination:CGFloat = sqrt((dX * dX) + (dY * dY))
            
            
            if(distanceToDestination < 64) {
                needToMove = false
            } else {
                switch(self.touchesArrayCount) {
                case 0:
                    if(abs(self.totalRotation) < 1){
                        self.physicsBody!.applyForce(CGVector(dx: -sin(self.zRotation) * 1000, dy: cos(self.zRotation) * 1000))
                    }
                    break
                    
                default:
                    //aplicar forca em direcao ao destino
                    self.physicsBody!.applyForce(CGVector(dx: (dX/distanceToDestination) * 1000, dy: (dY/distanceToDestination) * 1000))
                    break
                }
            }
        }
    }
    
    func setRotationToPoint(point:CGPoint) {
        self.rotation = CGFloat(M_PI) + CGFloat(-atan2f(Float(self.position.x - point.x), Float(self.position.y - point.y)))
    }
    
    func loadNewShip(index:Int, x:Int, y:Int, loadPhysics:Bool = false) {
        
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
        
        if(loadPhysics){
            //Physics Config
            self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.7, size: texture.size())
            self.physicsBody!.angularDamping = 10
            self.physicsBody!.linearDamping = 5
        }
        
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