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
    var timeToFade = 2.0
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
        self.backgroundColor = GameColors.gray
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        self.addChild(Control(name: "newGameBackground", x:0, y:0, align:.center))
        
        self.addChild(Button(name: "buttonNewGame", x:289, y:241, align:.center))
        self.addChild(Button(name: "buttonCancel", x:289, y:366, align:.center))
        self.addChild(Button(name: "buttonBack", x:81, y:633, xAlign:.left, yAlign:.down))
        self.addChild(Button(name: "buttonLeft", x:549, y:241, align:.center))
        self.addChild(Button(name: "buttonRight", x:663, y:241, align:.center))

        
        if(!NSUserDefaults.standardUserDefaults().boolForKey("firstlaunch")){
        

            newgameTutorial()

            
            
        }

        else{
        
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
         
        
            
        }
        
        let playerShip = PlayerShip(index: shipIndex, x:667, y:589)
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

//teste
    
    
    func newgameTutorial(){
        
        
        
        
        self.addChild(Label(name: "labelTutorial1" , textureName: "This is your maximum speed " , x:1189, y:264, align:.center))
        self.addChild(Label(name: "labelSpeed", textureName:"999", x:1014, y:264, align:.center))
        
        animation(childNodeWithName("labelTutorial1")!,timeToFade: timeToFade)
        
        self.addChild(Label(name: "labelTutorial2" , textureName: "This is your Acceleration rate " , x:1189, y:264, align:.center))
        self.addChild(Label(name: "labelAcceleration", textureName:"999", x:1014, y:342, align:.center))
        
        animation(childNodeWithName("labelTutorial2")!,timeToFade: timeToFade)
        
        self.addChild(Label(name: "labelTutorial3" , textureName: "This is how fast you turn " , x:1189, y:264, align:.center))
        self.addChild(Label(name: "labelAgility", textureName:"999", x:1014, y:420, align:.center))
        
        animation(childNodeWithName("labelTutorial3")!,timeToFade: timeToFade)
        
        self.addChild(Label(name: "labelTutorial4" , textureName: "This is how much you resist damage " , x:1189, y:264, align:.center))
        self.addChild(Label(name: "labelArmor", textureName:"999", x:1014, y:498, align:.center))
        
        animation(childNodeWithName("labelTutorial4")!,timeToFade: timeToFade)
        
        self.addChild(Label(name: "labelTutorial5" , textureName: "This is how much your shild resist " , x:1189, y:264, align:.center))
        self.addChild(Label(name: "labelShieldPower", textureName:"999", x:1014, y:576, align:.center))
        
        animation(childNodeWithName("labelTutorial5")!,timeToFade: timeToFade)
        
        self.addChild(Label(name: "labelTutorial6" , textureName: "This is how much your recharge persec " , x:1189, y:264, align:.center))
        self.addChild(Label(name: "labelShieldRecharge", textureName:"999", x:1014, y:655, align:.center))
        
        animation(childNodeWithName("labelTutorial6")!,timeToFade: timeToFade)
        
        
        self.addChild(Label(name: "labelScore", textureName:"$10000", x:645, y:357, align:.center))
        self.addChild(Label(name: "labelLevel", textureName:"Level: 1", x:645, y:420, align:.center))
        
        self.addChild(Label(name: "labelMaximumUP", textureName:"Maximum UP: 9999", x:408, y:507, align:.center))
        self.addChild(Label(name: "labelCurrentUP", textureName:"Current UP 9999", x:408, y:589, align:.center))
        self.addChild(Label(name: "labelAvailableUP", textureName:"Available UP 9999", x:408, y:671, align:.center))
        
        
        
       // NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstlaunch")
       // NSUserDefaults.standardUserDefaults().synchronize();
        
        
    }




    func animation(node:SKNode , timeToFade:Double ){
        
        var pause:SKAction = SKAction.waitForDuration(1)
        self.timeToFade = self.timeToFade + 2.0
        var fadeAway = SKAction.fadeOutWithDuration(timeToFade)
        var remove = SKAction.removeFromParent()
        var moveSequence = SKAction.sequence([pause, fadeAway, remove])
        
        node.runAction(moveSequence)
        
        
    }









}
