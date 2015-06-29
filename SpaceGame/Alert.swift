//
//  Alert.swift
//  SpaceGame
//
//  Created by Uriel on 24/06/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class Alert: Control {
    
    var touchesEndedAtButtonOK:Event<Void> = Event()

     init(text:String) {
        super.init(name: "messegeBox", textureName: "messageBoxBackground2", x: 412, y: 283, align:.center)
        
        self.zPosition = Config.HUDZPosition * CGFloat(2)
        
        self.addChild(Label(name:"label0", textureName:text, x:255, y:46))
        self.addChild(Button(name: "buttonOK", x:268, y:93))
        self.hidden = false
    }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesBegan(self, touches: touches as! Set<UITouch>)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesMoved(self)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        Button.touchesEnded(self, touches: touches as! Set<UITouch>)
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if (self.childNodeWithName("buttonOK")!.containsPoint(location) == true) {
                self.hidden = true
                self.touchesEndedAtButtonOK.raise()
                self.removeFromParent()
                return
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
    
    override var hidden: Bool {
        didSet {
            self.userInteractionEnabled = !hidden
        }
    }
    
    override func removeFromParent() {
        Control.locations.removeObject(self.name!)
        super.removeFromParent()
    }

}
