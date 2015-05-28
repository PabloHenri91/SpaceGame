//
//  MainMenuNewGame.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/22/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class NewGameScene: SKScene {
    
    enum states {
        case newGame
        case mainMenu
        case hangar
    }
    
    var state = states.newGame
    var nextState = states.newGame
    
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
        self.addChild(Button(name: "buttonCancel", x:289, y:366, align:.center))
        self.addChild(Button(name: "buttonBack", x:81, y:633, xAlign:.left, yAlign:.down))
        self.addChild(Button(name: "buttonLeft", x:549, y:241, align:.center))
        self.addChild(Button(name: "buttonRight", x:663, y:241, align:.center))
        
        self.addChild(Label(name: "labelSpeed", textureName:"999", x:1014, y:264, align:.center))
        self.addChild(Label(name: "labelAcceleration", textureName:"999", x:1014, y:342, align:.center))
        self.addChild(Label(name: "labelAgility", textureName:"999", x:1014, y:420, align:.center))
        self.addChild(Label(name: "labelArmor", textureName:"999", x:1014, y:498, align:.center))
        self.addChild(Label(name: "labelShieldPower", textureName:"999", x:1014, y:576, align:.center))
        self.addChild(Label(name: "labelShieldRecharge", textureName:"999", x:1014, y:655, align:.center))
        
        self.addChild(Label(name: "labelScore", textureName:"$10000", x:645, y:357, align:.center))
        self.addChild(Label(name: "labelLevel", textureName:"Level: 1", x:645, y:420, align:.center))
        
        self.addChild(Label(name: "labelMaximumUP", textureName:"Maximum UP: 9999", x:408, y:507, align:.center))
        self.addChild(Label(name: "labelCurrentUP", textureName:"Current UP 9999", x:408, y:589, align:.center))
        self.addChild(Label(name: "labelAvailableUP", textureName:"Available UP 9999", x:408, y:671, align:.center))
        
        
        let playerShip = PlayerShip(index: shipIndex)
        self.reloadAtributeLabels(playerShip)
        self.addChild(playerShip)
    }
    
    func reloadAtributeLabels(playerShip:PlayerShip) {
        (self.childNodeWithName("labelSpeed") as! Label).setText(playerShip.speedAtribute.description)
        (self.childNodeWithName("labelAcceleration") as! Label).setText(playerShip.acceleration.description)
        (self.childNodeWithName("labelAgility") as! Label).setText(playerShip.agility.description)
        (self.childNodeWithName("labelArmor") as! Label).setText(playerShip.armor.description)
        (self.childNodeWithName("labelShieldPower") as! Label).setText(playerShip.shieldPower.description)
        (self.childNodeWithName("labelShieldRecharge") as! Label).setText(playerShip.shieldRecharge.description)
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
                    shipIndex = Config.playerTypesCount - 1
                }
                
                let playerShip = self.childNodeWithName("player") as! PlayerShip
                playerShip.reloadNewShip(shipIndex)
                self.reloadAtributeLabels(playerShip)
                
                return
            }
            
            if (self.childNodeWithName("buttonRight")!.containsPoint(location)) {
                shipIndex++
                if(shipIndex >= Config.playerTypesCount ){
                    shipIndex = 0
                }
                
                let playerShip = self.childNodeWithName("player") as! PlayerShip
                playerShip.reloadNewShip(shipIndex)
                self.reloadAtributeLabels(playerShip)
                
                return
            }
            
            if (self.childNodeWithName("buttonNewGame")!.containsPoint(location)) {
                GameViewController.memoryCard.newGame(shipIndex)
                self.view!.presentScene(HangarScene(), transition: SKTransition.crossFadeWithDuration(1))
            }
            
            if (self.childNodeWithName("buttonBack")!.containsPoint(location) || self.childNodeWithName("buttonCancel")!.containsPoint(location)) {
                self.view!.presentScene(MainMenuScene(), transition: SKTransition.crossFadeWithDuration(1))
                return
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self, touches: touches as! Set<UITouch>)
    }
}
