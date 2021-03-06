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
        case newGame
        case hangar
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
        self.backgroundColor = GameColors.gray
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        self.addChild(Control(name: "mainMenuBackground", x:0, y:0, align:.center))
        
        self.addChild(Button(name: "buttonPlay", x:549, y:317, align:.center))
        self.addChild(Button(name: "buttonOptions", x: 549, y: 409, align:.center))
        self.addChild(Button(name: "buttonCredits", x: 549, y: 501, align:.center))
    }
    
    override func update(currentTime: NSTimeInterval) {
        if(self.state == self.nextState){
            switch (self.state) {
            default:
                break
            }
        }  else {
            self.state = self.nextState
            
            switch (self.nextState) {
                
            case states.newGame:
                self.view!.presentScene(NewGameScene(), transition: SKTransition.crossFadeWithDuration(1))
                break
                
            case states.hangar:
                self.view!.presentScene(HangarScene(), transition: SKTransition.crossFadeWithDuration(1))
                break
                
            case states.options:
                self.view!.presentScene(OptionsScene(), transition: SKTransition.crossFadeWithDuration(1))
                break
                
            case states.credits:
                self.view!.presentScene(creditScene(), transition: SKTransition.crossFadeWithDuration(1))
                break
                
            default:
                break
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Control.touchesBegan(self, touches: touches )
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Control.touchesMoved(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Control.touchesEnded(self, touches: touches )
        
        if (self.state == self.nextState) {
            switch (self.state) {
            case states.mainMenu:
                for touch in (touches ) {
                    let location = touch.locationInNode(self)
                    
                    if (self.childNodeWithName("buttonPlay")!.containsPoint(location)) {
                        if(GameViewController.memoryCard.loadGame()) {
                            self.nextState = .hangar
                        } else {
                            self.nextState = .newGame
                        }
                        return
                    }
                    
                    if (self.childNodeWithName("buttonOptions")!.containsPoint(location)) {
                        self.nextState = .options
                        return
                    }
                    if (self.childNodeWithName("buttonCredits")!.containsPoint(location)) {
                        self.nextState = .credits
                        return
                    }
                }
                break
                
            default:
                break
            }
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        Control.touchesEnded(self, touches: touches! as Set<UITouch>)
    }
}