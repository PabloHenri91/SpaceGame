//
//  HangarScene.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/26/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class HangarScene: SKScene {
    override init() {
        Control.locations = NSMutableArray()
        super.init(size: Config.sceneSize())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        self.scaleMode = SKSceneScaleMode.AspectFit
        self.backgroundColor = Config.myGray
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        self.addChild(Control(name: "hangarBackground", x: 0, y: 0, align:.center))
        
        self.addChild(Button(name: "buttonPlayMission", x: 936, y: 68, align:.center))
        self.addChild(Button(name: "buttonSupplyRoom", x: 936, y: 164, align:.center))
        self.addChild(Button(name: "buttonAllyShip", x: 936, y: 260, align:.center))
        self.addChild(Button(name: "buttonLevelUp", x: 656, y: 478, align:.center))
        
        self.addChild(Button(name: "buttonLeftSpeed", textureName: "buttonLeft", x: 363, y: 68, align:.center))
        self.addChild(Button(name: "buttonLeftAcceleration", textureName: "buttonLeft", x: 363, y: 174, align:.center))
        self.addChild(Button(name: "buttonLeftAgility", textureName: "buttonLeft", x: 363, y: 280, align:.center))
        self.addChild(Button(name: "buttonLeftArmor", textureName: "buttonLeft", x: 363, y: 386, align:.center))
        self.addChild(Button(name: "buttonLeftShieldPower", textureName: "buttonLeft", x: 363, y: 492, align:.center))
        self.addChild(Button(name: "buttonLeftShieldRecharge", textureName: "buttonLeft", x: 363, y: 600, align:.center))
        
        self.addChild(Button(name: "buttonRightSpeed", textureName: "buttonRight", x: 532, y: 68, align:.center))
        self.addChild(Button(name: "buttonRightAcceleration", textureName: "buttonRight", x: 532, y: 174, align:.center))
        self.addChild(Button(name: "buttonRightAgility", textureName: "buttonRight", x: 532, y: 280, align:.center))
        self.addChild(Button(name: "buttonRightArmor", textureName: "buttonRight", x: 532, y: 386, align:.center))
        self.addChild(Button(name: "buttonRightShieldPower", textureName: "buttonRight", x: 532, y: 492, align:.center))
        self.addChild(Button(name: "buttonRightShieldRecharge", textureName: "buttonRight", x: 532, y: 600, align:.center))
        
        self.addChild(Button(name: "buttonBack", x:81, y:633, xAlign:.left, yAlign:.down))
        
        self.addChild(PlayerShip(index: Int(GameViewController.memoryCard.playerData!.currentPlayerShip.shopIndex), x: 776, y: 341))
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
                self.view?.presentScene(MainMenuScene(), transition: SKTransition.crossFadeWithDuration(1))
                return
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
}
