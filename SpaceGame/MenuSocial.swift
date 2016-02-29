//
//  MenuSocial.swift
//  SpaceGame
//
//  Created by Uriel on 02/07/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit

class MenuSocial: Control {
    var touchesEndedAtButtonCancel:Event<Void> = Event()
    var touchesEndedAtButtonSendShip:Event<Void> = Event()
    var touchesEndedAtButtonFavorite:Event<Void> = Event()
    
    init(text:String) {
        super.init(name: "messegeBox", textureName: "messageBoxBackgroundSocial", x: 504, y: 203, align:.center)
        
        self.zPosition = Config.HUDZPosition * CGFloat(2)
        
        self.addChild(Button(name: "buttonFavorite", x:57, y:33))
        self.addChild(Button(name: "buttonSendShip", x:57, y:151))
        self.addChild(Button(name: "buttonCancel", x:57, y:269))
        self.hidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Control.touchesBegan(self, touches: touches )
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Control.touchesMoved(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Button.touchesEnded(self, touches: touches )
        for touch in (touches ) {
            let location = touch.locationInNode(self)
            
            if (self.childNodeWithName("buttonFavorite")!.containsPoint(location) == true) {
                self.hidden = true
                self.touchesEndedAtButtonFavorite.raise()
                self.removeFromParent()
                return
            }
            if (self.childNodeWithName("buttonSendShip")!.containsPoint(location) == true) {
                self.hidden = true
                self.touchesEndedAtButtonSendShip.raise()
                self.removeFromParent()
                return
            }
            if (self.childNodeWithName("buttonCancel")!.containsPoint(location) == true) {
                self.hidden = true
                self.touchesEndedAtButtonCancel.raise()
                self.removeFromParent()
                return
            }
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        Control.touchesEnded(self.scene!, touches: touches! as Set<UITouch>)
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
