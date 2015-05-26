//
//  MainMenuNewGame.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/22/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class NewGameScene: SKScene {
    
    var shipIndex:Int = 0
    
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
        
        self.addChild(Control(name: "newGameBackground", x:0, y:0, align:.center))
        
        self.addChild(Button(name: "buttonNewGame", x:289, y:241, align:.center))
        self.addChild(Button(name: "buttonBack", x:81, y:633, xAlign:.left, yAlign:.down))
        self.addChild(Button(name: "buttonLeft", x:549, y:241, align:.center))
        self.addChild(Button(name: "buttonRight", x:663, y:241, align:.center))
        
        self.addChild(PlayerShip(index: shipIndex))
        
        self.hidden = false
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
            
            if (self.childNodeWithName("buttonLeft")!.containsPoint(location)) {
                shipIndex--
                if(shipIndex < 0 ){
                    shipIndex = Config.playerTypesCount
                }
                
                (self.childNodeWithName("player") as! PlayerShip).reloadNewShip(shipIndex)
                
                return;
            }
            if (self.childNodeWithName("buttonRight")!.containsPoint(location)) {
                
                return;
            }
            if (self.childNodeWithName("buttonBack")!.containsPoint(location)) {
                self.view!.presentScene(MainMenuScene(), transition: SKTransition.crossFadeWithDuration(1))
                return;
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
    
    override var hidden: Bool {
        didSet {
            self.userInteractionEnabled = !hidden;
        }
    }
}
