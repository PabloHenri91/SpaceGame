//
//  GameScene.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/20/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class SpaceScene: SKScene {
    
    let playerData:PlayerData = GameViewController.memoryCard.playerData!
    
    override init() {
        Control.locations = NSMutableArray()
        super.init(size: Config.sceneSize())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        self.scaleMode = SKSceneScaleMode.AspectFit
        self.backgroundColor = UIColor.blackColor()
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        var world = SKNode()//Criar classe World?
        world.name = "world"
        self.addChild(world)
        
        var camera = SKNode()//Criar classe Camera?
        camera.name = "camera"
        world.addChild(camera)
        
        var player = PlayerShip(playerShipData: self.playerData.currentPlayerShip, x: 0, y: 0, loadPhysics:true)
        Control.locations.removeObject("player")
        world.addChild(player)
        
        self.addChild(Button(name: "buttonBack", x:81, y:633, xAlign:.left, yAlign:.down))
        
        self.physicsWorld.gravity = CGVector.zeroVector
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        
    }
    
    override func didFinishUpdate ()
    {
        let player = self.childNodeWithName("//player")!
        let camera = self.childNodeWithName("//camera")!
        camera.position = CGPoint(x: player.position.x - self.size.width/2 , y: player.position.y + self.size.height/2)
        self.centerOnNode(camera)
    }
    
    ///The centerOnNode: method converts the camera’s current position into scene coordinates, then subtracts those coordinates from the world’s position to slide the character to the (0,0) position.
    func centerOnNode(node:SKNode)
    {
        var cameraPositionInScene:CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
        node.parent!.position = CGPoint(x: node.parent!.position.x - cameraPositionInScene.x, y: node.parent!.position.y - cameraPositionInScene.y)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesBegan(self, touches: touches as! Set<UITouch>)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesMoved(self)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesEnded(self, touches: touches as! Set<UITouch>)
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if (self.childNodeWithName("buttonBack")!.containsPoint(location)) {
                self.view?.presentScene(HangarScene(), transition: SKTransition.crossFadeWithDuration(1))
                return
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
}
