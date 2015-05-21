//
//  MainMenuScene.swift
//  SuperAwesomeGame
//
//  Created by Pablo Henrique Bertaco on 5/20/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    enum states {
        case mainMenu
        case game
        case options
        case credits
    }
    
    var state = states.mainMenu
    var nextState = states.mainMenu
    
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
        
        var textures2Dlocations = NSMutableArray()
        
        self.addChild(Control(name: "mainMenuBackground", x:0, y:0))
        
        self.addChild(Button(name: "buttonPlay", x:549, y:317))
        self.addChild(Button(name: "buttonOptions", x: 549, y: 409))
        self.addChild(Button(name: "buttonCredits", x: 549, y: 501))
    }
    
    override func update(currentTime: NSTimeInterval) {
        if(self.state == self.nextState){
            switch (self.state) {
            default:
                break;
            }
        }  else {
            self.state = self.nextState;
            
            switch (self.nextState) {
                
            case states.game:
                self.view!.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(2))
                break;
                
            default:
                break;
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        Button.touchesBegan(self, touches: touches as! Set<UITouch>)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        Button.touchesMoved(self, touches: touches as! Set<UITouch>)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        Button.touchesEnded(self, touches: touches as! Set<UITouch>)
        
        if (self.state == self.nextState) {
            switch (self.state) {
            case states.mainMenu:
                for touch in (touches as! Set<UITouch>) {
                    let location = touch.locationInNode(self)
                    
                    if (self.childNodeWithName("buttonPlay")!.containsPoint(location) == true) {
                        self.nextState = states.game;
                        return;
                    }
                }
                break;
                
            default:
                break;
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Button.touchesEnded(self, touches: touches as! Set<UITouch>)
    }
}