//
//  MainMenuNewGame.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/22/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class NewGame: Control {
    init(){
        super.init(name: "NewGame", textureName: "newGameBackground", x: 0, y: 0)
        
        self.addChild(Button(name: "buttonNewGame", x:289, y:241))
        self.addChild(Button(name: "buttonBack", x:81, y:633, align:alignments.left))
        
        self.hidden = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        Button.touchesBegan(self, touches: touches as! Set<UITouch>)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        Button.touchesMoved(self, touches: touches as! Set<UITouch>)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        Button.touchesEnded(self, touches: touches as! Set<UITouch>)
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if (self.childNodeWithName("buttonBack")!.containsPoint(location) == true) {
                self.hidden = true
                (self.scene as! MainMenuScene).nextState = MainMenuScene.states.mainMenu
                return;
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Button.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
    
    override var hidden: Bool {
        didSet {
            self.userInteractionEnabled = !hidden;
        }
    }
}
