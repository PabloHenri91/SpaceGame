//
//  PlayerShip.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/22/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class PlayerShip: Ship {
    
    //Toques
    var lastNoTouchTime:Double = 0
    var touchesArrayCount: Int = 0
    var lastTouchesArrayCount: Int = 0
    var firstTouchLocation:CGPoint = CGPoint.zero
    var lastTouchLocation:CGPoint = CGPoint.zero
    
    //Tiros
    var lastFire:Double = 0
    
    var hardPoints:NSMutableArray = NSMutableArray()
    
    ///Inicializa nave nova sem física.
    init(index:Int, x:Int, y:Int) {
        super.init(index: index, name: "player", x: x, y: y)
    }
    
    ///Inicializa nave com dados do CoreData e física opcional.
    init(playerShipData:PlayerShipData, x:Int, y:Int, loadPhysics:Bool) {
        super.init()
        self.loadNewShip(Int(playerShipData.shopIndex), name:"player", x: x, y: y, loadPhysics:loadPhysics)
        
        self.level = Int(playerShipData.level)
        
        self.speedAtribute += Int(playerShipData.bonusSpeed)
        self.acceleration += Int(playerShipData.bonusAcceleration)
        self.agility += Int(playerShipData.bonusAgility)
        self.armor += Int(playerShipData.bonusArmor)
        self.shieldPower += Int(playerShipData.bonusShieldPower)
        self.shieldRecharge += Int(playerShipData.bonusShieldRecharge)
        
        if(loadPhysics){
            self.angularImpulse = GameMath.angularImpulse(self.agility)
            self.maxAngularVelocity = GameMath.maxAngularVelocity(self.agility)
            self.maxLinearVelocity = GameMath.maxLinearVelocity(self.speedAtribute)
            self.force = GameMath.force(self.acceleration)
        }
        
        for hardPointData in playerShipData.hardPoints {
            self.hardPoints.addObject(HardPoint(hardPointData: hardPointData as! HardPointData))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    func update(currentTime: NSTimeInterval) {
        if (currentTime - self.lastFire > 0.5) {
            self.parent!.addChild(Shot(position: self.position, zRotation: self.zRotation))
            self.lastFire = currentTime
        }
        
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
            self.firstTouchLocation = (Control.touchesArray[0] as! UITouch).locationInNode(self.parent!)
            
            self.setRotationToPoint(self.firstTouchLocation)
            break
            
            //Mais de um toque
        default:
            
            self.firstTouchLocation = (Control.touchesArray[0] as! UITouch).locationInNode(self.parent!)
            self.lastTouchLocation = (Control.touchesArray.lastObject as! UITouch).locationInNode(self.parent!)
            
            self.needToMove = true
            self.startMoving = currentTime
            self.destination = lastTouchLocation
            
            self.setRotationToPoint(self.firstTouchLocation)
            
            break
        }
        
        if(currentTime - self.startMoving > 5){
            self.needToMove = false
        }
        
        if(abs(self.physicsBody!.angularVelocity) < self.maxAngularVelocity && (self.needToMove || self.touchesArrayCount > 0)) {
            self.totalRotation = self.rotation - self.zRotation
            
            while(self.totalRotation < -CGFloat(M_PI)) { self.totalRotation += CGFloat(M_PI * 2) }
            while(self.totalRotation >  CGFloat(M_PI)) { self.totalRotation -= CGFloat(M_PI * 2) }
            
            self.physicsBody!.applyAngularImpulse(self.totalRotation *  self.angularImpulse)
        }
        
        if (self.needToMove) {
            var dX:CGFloat = destination.x - self.position.x
            var dY:CGFloat = destination.y - self.position.y
            var distanceToDestination:CGFloat = sqrt((dX * dX) + (dY * dY))
            
            
            if(distanceToDestination < 64) {
                needToMove = false
            } else {
                let velocity = self.physicsBody!.velocity
                if (sqrt(velocity.dx * velocity.dx + velocity.dy * velocity.dy) < self.maxLinearVelocity) {
                    switch(self.touchesArrayCount) {
                    case 0:
                        if(abs(self.totalRotation) < 1){
                            self.physicsBody!.applyForce(CGVector(dx: -sin(self.zRotation) * self.force, dy: cos(self.zRotation) * self.force))
                        }
                        break
                        
                    default:
                        //aplicar forca em direcao ao destino
                        self.physicsBody!.applyForce(CGVector(dx: (dX/distanceToDestination) * self.force, dy: (dY/distanceToDestination) * self.force))
                        break
                    }
                } else {
                    var a = 0
                }
            }
        }
    }
    
    func updatePlayerDataCurrentPlayerShip() {
        let currentPlayerShip = GameViewController.memoryCard.playerData.currentPlayerShip
        let shipType = Ships.types[self.type] as! ShipType
        
        currentPlayerShip.level = self.level
        
        currentPlayerShip.bonusSpeed = self.speedAtribute - shipType.speed
        currentPlayerShip.bonusAcceleration = self.acceleration - shipType.acceleration
        currentPlayerShip.bonusAgility = self.agility - shipType.agility
        currentPlayerShip.bonusArmor = self.armor - shipType.armor
        currentPlayerShip.bonusShieldPower = self.shieldPower - shipType.shieldPower
        currentPlayerShip.bonusShieldRecharge = self.shieldRecharge - shipType.shieldRecharge
    }
}