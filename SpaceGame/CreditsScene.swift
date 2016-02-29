//
//  CreditsScene.swift
//  SpaceGame
//
//  Created by Gabriel Prado Marcolino on 29/06/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit
import AVFoundation


class creditScene : SKScene{

    enum states {
        
        case mainMenu
        case credits
        case loading
    }
    
    var state = states.loading
    var nextState = states.credits
 
    
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
        
        self.addChild(Control(name: "CreditsBackground", x:0, y:0, align:.center))
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
                
            case states.credits:
                Audio.prepareAudios("starWars")
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
        for touch in (touches ) {
            let location = touch.locationInNode(self)
        
        if (self.childNodeWithName("buttonBack")!.containsPoint(location)) {
         //   sound.stop()
            Audio.stopAudio("starWars")
            self.view!.presentScene(MainMenuScene(), transition: SKTransition.crossFadeWithDuration(1))
            return
            
    }
}
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        Control.touchesEnded(self, touches: touches! as Set<UITouch>)
    }
    
}
