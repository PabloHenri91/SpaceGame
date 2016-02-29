//
//  WeaponsScene.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 7/6/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class ArmoryScene: SKScene {
    
    enum states {
        case armory
        case hangar
    }
    
    var state = states.armory
    var nextState = states.armory
    
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
        
        self.addChild(Control(name: "weaponsBackground", x:0, y:0, align:.center))
        
        self.addChild(Button(name: "buttonBack", x:42, y:649, xAlign:.left, yAlign:.down))
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
                
            case states.hangar:
                self.view!.presentScene(HangarScene(), transition: SKTransition.crossFadeWithDuration(1))
                
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
            case states.armory:
                for touch in (touches ) {
                    let location = touch.locationInNode(self)
                    
                    if (self.childNodeWithName("buttonBack")!.containsPoint(location)) {
                        self.nextState = states.hangar
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
