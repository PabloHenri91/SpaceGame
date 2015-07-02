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
    
    var region:Int = 0
    var lastRegion:Int = 0
    
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
        
        let world = SKNode()//Criar classe World?
        world.name = "world"
        self.addChild(world)
        
        let camera = SKNode()//Criar classe Camera?
        camera.name = "camera"
        world.addChild(camera)
        
        let player = PlayerShip(playerShipData: self.playerData.currentPlayerShip, x: 0, y: 0, loadPhysics:true)
        Control.locations.removeObject("player")
        world.addChild(player)
        
        let mapManager = MapManager()
        mapManager.name = "mapManager"
        world.addChild(mapManager);
        mapManager.reloadMap()
        
        self.addChild(Button(name: "buttonBack", x:81, y:633, xAlign:.left, yAlign:.down))
        
        //HUD
        //self.addChild(Control(name: "hudLeftUp", x: 0, y: 0, xAlign:.left, yAlign:.up))
        var label = Label(name: "labelRegion", textureName: "Region:  0", x: 14, y: 98, xAlign: .left, yAlign: .up)
        (label.childNodeWithName("labelRegion") as! SKLabelNode).horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        self.addChild(label)
        
        label = Label(name: "labelDistance", textureName: "Distance: 0", x: 14, y: 37, xAlign: .left, yAlign: .up)
        (label.childNodeWithName("labelDistance") as! SKLabelNode).horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        self.addChild(label)
        
        self.physicsWorld.gravity = CGVector.zeroVector
    }
    
    override func update(currentTime: NSTimeInterval) {
        let player = (self.childNodeWithName("//player") as! PlayerShip)
        player.update(currentTime)
        
        
        
        NSArray(array: player.parent!.children).enumerateObjectsUsingBlock({ object, index, stop in
            var node = object as! SKNode
            
            if let name = node.name
            {
                
                if(name.hasPrefix("enemy")) {
                    (node as! EnemyShip).update(currentTime, playerPosition: player.position)
                } else {
                    
                }
                
            }
         })
    
        

        
        let mapManager = (self.childNodeWithName("//mapManager")! as! MapManager)
        var distance = Int(sqrt(player.position.x * player.position.x + player.position.y * player.position.y))
        mapManager.update(currentTime, playerShip:player, region:distance/10000)
        
        
        let labelRegion = self.childNodeWithName("//labelRegion")! as! Label
        labelRegion.setText("Region: \(distance/10000)")
        
        let labelDistance = self.childNodeWithName("//labelDistance")! as! Label
        labelDistance.setText("Distance: \(distance/10)")
        
    }
    
    override func didFinishUpdate()
    {
        let player = self.childNodeWithName("//player")!
        let camera = self.childNodeWithName("//camera")!
        camera.position = CGPoint(x: player.position.x - self.size.width/2 , y: player.position.y + self.size.height/2)
        self.centerOnNode(camera)
    }
    
    ///The centerOnNode: method converts the camera’s current position into scene coordinates, then subtracts those coordinates from the world’s position to slide the character to the (0,0) position.
    func centerOnNode(node:SKNode)
    {
        let cameraPositionInScene:CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)
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
