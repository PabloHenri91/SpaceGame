//
//  HangarScene.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/26/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class HangarScene: SKScene {
    
    let playerData:PlayerData = GameViewController.memoryCard.playerData!
    
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
        
        self.addChild(Control(name: "hangarBackground", x: 0, y: 0, align:.center))
        
        self.addChild(Button(name: "buttonPlayMission", x: 936, y: 91, align:.center))
        self.addChild(Button(name: "buttonSupplyRoom", x: 936, y: 187, align:.center))
        self.addChild(Button(name: "buttonAllyShip", x: 936, y: 283, align:.center))
        self.addChild(Button(name: "buttonLevelUp", x: 656, y: 501, align:.center))
        
        self.addChild(Button(name: "buttonLeftSpeed", textureName: "buttonLeft", x: 363, y: 91, align:.center))
        self.addChild(Button(name: "buttonLeftAcceleration", textureName: "buttonLeft", x: 363, y: 197, align:.center))
        self.addChild(Button(name: "buttonLeftAgility", textureName: "buttonLeft", x: 363, y: 303, align:.center))
        self.addChild(Button(name: "buttonLeftArmor", textureName: "buttonLeft", x: 363, y: 409, align:.center))
        self.addChild(Button(name: "buttonLeftShieldPower", textureName: "buttonLeft", x: 363, y: 515, align:.center))
        self.addChild(Button(name: "buttonLeftShieldRecharge", textureName: "buttonLeft", x: 363, y: 623, align:.center))
        
        self.addChild(Button(name: "buttonRightSpeed", textureName: "buttonRight", x: 532, y: 91, align:.center))
        self.addChild(Button(name: "buttonRightAcceleration", textureName: "buttonRight", x: 532, y: 197, align:.center))
        self.addChild(Button(name: "buttonRightAgility", textureName: "buttonRight", x: 532, y: 303, align:.center))
        self.addChild(Button(name: "buttonRightArmor", textureName: "buttonRight", x: 532, y: 409, align:.center))
        self.addChild(Button(name: "buttonRightShieldPower", textureName: "buttonRight", x: 532, y: 515, align:.center))
        self.addChild(Button(name: "buttonRightShieldRecharge", textureName: "buttonRight", x: 532, y: 623, align:.center))
        
        let playerShip = PlayerShip(playerShipData: self.playerData.currentPlayerShip, x: 776, y: 364)
        self.addChild(playerShip)
        
        self.addChild(Label(name:"labelSpeed", textureName:"0", x:487, y:130, align:.center))
        self.addChild(Label(name:"labelAcceleration", textureName:"0", x:487, y:236, align:.center))
        self.addChild(Label(name:"labelAgility", textureName:"0", x:487, y:342, align:.center))
        self.addChild(Label(name:"labelArmor", textureName:"0", x:487, y:448, align:.center))
        self.addChild(Label(name:"labelShieldPower", textureName:"0", x:487, y:554, align:.center))
        self.addChild(Label(name:"labelShieldRecharge", textureName:"0", x:487, y:662, align:.center))
        
        self.addChild(Label(name:"labelMaximumUP", textureName:"Maximum UP: 0", x:775, y:98, align:.center))
        self.addChild(Label(name:"labelCurrentUP", textureName:"Current UP: 0", x:775, y:159, align:.center))
        self.addChild(Label(name:"labelAvailableUP", textureName:"Available UP: 0", x:775, y:220, align:.center))
        
        self.addChild(Label(name:"labelRequiredPoints", textureName:"$0", x:773, y:620, align:.center))
        self.addChild(Label(name:"labelLevel", textureName:"Level: 0", x:773, y:681, align:.center))
        
        self.addChild(Label(name:"labelScore", textureName:"$0", x:267, y:39, align:.center))
        
        self.addChild(Button(name: "buttonBack", x:28, y:657, xAlign:.left, yAlign:.down))
        
        self.updatePlayerShipAtributeLabels()
    }
    
    func updatePlayerShipAtributeLabels() {
        let playerShip = self.childNodeWithName("player") as! PlayerShip
        
        (self.childNodeWithName("labelSpeed") as! Label).setText(playerShip.speedAtribute.description)
        (self.childNodeWithName("labelAcceleration") as! Label).setText(playerShip.acceleration.description)
        (self.childNodeWithName("labelAgility") as! Label).setText(playerShip.agility.description)
        (self.childNodeWithName("labelArmor") as! Label).setText(playerShip.armor.description)
        (self.childNodeWithName("labelShieldPower") as! Label).setText(playerShip.shieldPower.description)
        (self.childNodeWithName("labelShieldRecharge") as! Label).setText(playerShip.shieldRecharge.description)
        
        (self.childNodeWithName("labelMaximumUP") as! Label).setText("Maximum UP: " + GameMath.maximumUP(playerShip.level).description)
        (self.childNodeWithName("labelCurrentUP") as! Label).setText("Current UP: " + GameMath.currentUP(playerShip).description)
        (self.childNodeWithName("labelAvailableUP") as! Label).setText("Available UP: " + GameMath.availableUP(playerShip).description)
        
        var requiredPoints = GameMath.requiredPoints(playerShip.level)
        
        var color:UIColor!
        if(Int(self.playerData.score) >= requiredPoints){
            color = GameColors.green
        } else {
            color = GameColors.red
        }
        (self.childNodeWithName("labelRequiredPoints") as! Label).setText("$" + requiredPoints.description, color:color)
        (self.childNodeWithName("labelLevel") as! Label).setText("Level: " + playerShip.level.description)
        
        (self.childNodeWithName("labelScore") as! Label).setText("$" + self.playerData.score.description)
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
            
            if (self.childNodeWithName("buttonBack")!.containsPoint(location)) {
                self.view?.presentScene(MainMenuScene(), transition: SKTransition.crossFadeWithDuration(1))
                return
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
}
