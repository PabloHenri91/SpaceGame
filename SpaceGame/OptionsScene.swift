//
//  OptionsScene.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/28/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class OptionsScene: SKScene {
    
    enum states {
        case options
        case deleteSavedGame
        case mainMenu
    }
    
    var state = states.options
    var nextState = states.options
    
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
        
        self.addChild(Control(name: "optionsBackground", x:0, y:0, align:.center))
        
        self.addChild(Button(name: "buttonDeleteSavedGame", x:272, y:223, align:.center))
        
        self.addChild(Button(name: "buttonBack", x:81, y:633, xAlign:.left, yAlign:.down))
        
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
                
            case .deleteSavedGame:
                var messageBox = MessageBox(text: "Are you sure you want to delete?")
                messageBox.touchesEndedAtButtonOK.addHandler({
                    GameViewController.memoryCard.reset()
                    self.nextState = .options
                })
                messageBox.touchesEndedAtButtonCancel.addHandler({
                    self.nextState = .options
                })
                self.addChild(messageBox)
                break
                
            case .mainMenu:
                self.view!.presentScene(MainMenuScene(), transition: SKTransition.crossFadeWithDuration(1))
                break
                
            default:
                break
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesBegan(self, touches: touches as! Set<UITouch>)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesMoved(self)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesEnded(self, touches: touches as! Set<UITouch>)
        
        if (self.state == self.nextState) {
            switch (self.state) {
            case states.options:
                
                for touch in (touches as! Set<UITouch>) {
                    let location = touch.locationInNode(self)
                    
                    if (self.childNodeWithName("buttonDeleteSavedGame")!.containsPoint(location)) {
                        self.nextState = .deleteSavedGame
                    }
                    
                    if (self.childNodeWithName("buttonBack")!.containsPoint(location)) {
                        self.nextState = .mainMenu
                        return;
                    }
                }
                break
                
            case .deleteSavedGame:
                break
                
            default:
                break
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self, touches: touches as! Set<UITouch>)
    }
}
