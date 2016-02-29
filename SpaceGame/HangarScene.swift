//
//  HangarScene.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/26/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class HangarScene: SKScene {
    
    enum states {
        case hangar
        case playMission
        case supplyRoom
        case armory
        case allyShip
        case mainMenu
    }
    
    var state = states.hangar
    var nextState = states.hangar
    
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
        
        let playerShip = PlayerShip(playerShipData: self.playerData.currentPlayerShip, x: 776, y: 364, loadPhysics:false)
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
        
        self.updateControls()
    }
    
    func updateControls() {
        let playerShip = self.childNodeWithName("player") as! PlayerShip
        
        //Labels
        (self.childNodeWithName("labelSpeed") as! Label).setText(playerShip.speedAtribute.description)
        (self.childNodeWithName("labelAcceleration") as! Label).setText(playerShip.acceleration.description)
        (self.childNodeWithName("labelAgility") as! Label).setText(playerShip.agility.description)
        (self.childNodeWithName("labelArmor") as! Label).setText(playerShip.armor.description)
        (self.childNodeWithName("labelShieldPower") as! Label).setText(playerShip.shieldPower.description)
        (self.childNodeWithName("labelShieldRecharge") as! Label).setText(playerShip.shieldRecharge.description)
        
        (self.childNodeWithName("labelMaximumUP") as! Label).setText("Maximum UP: " + GameMath.maximumUP(playerShip.level).description)
        (self.childNodeWithName("labelCurrentUP") as! Label).setText("Current UP: " + GameMath.currentUP(playerShip).description)
        (self.childNodeWithName("labelAvailableUP") as! Label).setText("Available UP: " + GameMath.availableUP(playerShip).description)
        
        let requiredPoints = GameMath.requiredPoints(playerShip.level)
        
        let color:UIColor!
        if(Int(self.playerData.score) >= requiredPoints){
            color = GameColors.green
        } else {
            color = GameColors.red
        }
        (self.childNodeWithName("labelRequiredPoints") as! Label).setText("$" + requiredPoints.description, color:color)
        (self.childNodeWithName("labelLevel") as! Label).setText("Level: " + playerShip.level.description)
        
        (self.childNodeWithName("labelScore") as! Label).setText("$" + self.playerData.score.description)
        
        //Buttons
        let aux = GameMath.availableUP(playerShip) <= 0
        (self.childNodeWithName("buttonRightSpeed") as! Button).hidden = aux || playerShip.speedAtribute >= 100
        (self.childNodeWithName("buttonRightAcceleration") as! Button).hidden = aux || playerShip.acceleration >= 100
        (self.childNodeWithName("buttonRightAgility") as! Button).hidden = aux || playerShip.agility >= 100
        (self.childNodeWithName("buttonRightArmor") as! Button).hidden = aux || playerShip.armor >= 100
        (self.childNodeWithName("buttonRightShieldPower") as! Button).hidden = aux || playerShip.shieldPower >= 100
        (self.childNodeWithName("buttonRightShieldRecharge") as! Button).hidden = aux || playerShip.shieldRecharge >= 100
        
        let playerType = Ships.types[playerShip.type] as! ShipType
        (self.childNodeWithName("buttonLeftSpeed") as! Button).hidden = playerShip.speedAtribute <= playerType.speed
        (self.childNodeWithName("buttonLeftAcceleration") as! Button).hidden = playerShip.acceleration <= playerType.acceleration
        (self.childNodeWithName("buttonLeftAgility") as! Button).hidden = playerShip.agility <= playerType.agility
        (self.childNodeWithName("buttonLeftArmor") as! Button).hidden = playerShip.armor <= playerType.armor
        (self.childNodeWithName("buttonLeftShieldPower") as! Button).hidden = playerShip.shieldPower <= playerType.shieldPower
        (self.childNodeWithName("buttonLeftShieldRecharge") as! Button).hidden = playerShip.shieldRecharge <= playerType.shieldRecharge
    }
    
    override func update(currentTime: NSTimeInterval) {
        if(self.state == self.nextState) {
            switch (self.state) {
            default:
                break
            }
        }  else {
            self.state = self.nextState
            
            switch (self.nextState) {
                
            case states.playMission:
                self.view!.presentScene(SpaceScene(), transition: SKTransition.crossFadeWithDuration(1))
                break
                
            case states.armory:
                self.view!.presentScene(ArmoryScene(), transition: SKTransition.crossFadeWithDuration(1))
                break
                
            case states.supplyRoom:
                self.view!.presentScene(SupplyRoomScene(), transition: SKTransition.crossFadeWithDuration(1))
                break
                
            case states.allyShip:
                //self.view!.presentScene(SocialScene(), transition: SKTransition.crossFadeWithDuration(1))
                break
            case states.mainMenu:
                self.view!.presentScene(MainMenuScene(), transition: SKTransition.crossFadeWithDuration(1))
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
            case states.hangar:
                for touch in (touches ) {
                    let location = touch.locationInNode(self)
                    
                    if (self.childNodeWithName("buttonPlayMission")!.containsPoint(location)) {
                        self.nextState = .playMission
                        return
                    }
                    if (self.childNodeWithName("buttonSupplyRoom")!.containsPoint(location)) {
                        self.nextState = .armory
                        return
                    }
                    if (self.childNodeWithName("buttonAllyShip")!.containsPoint(location)) {
                        self.nextState = .allyShip
                        return
                    }
                    if (self.childNodeWithName("buttonBack")!.containsPoint(location)) {
                        self.nextState = .mainMenu
                        return
                    }
                    
                    let playerShip = self.childNodeWithName("player") as! PlayerShip
                    
                    if(playerShip.containsPoint(location)){
                        self.nextState = .supplyRoom
                        return
                    }
                    
                    let playerType = Ships.types[playerShip.type] as! ShipType
                    
                    if (self.childNodeWithName("buttonLevelUp")!.containsPoint(location)) {
                        let requiredPoints = GameMath.requiredPoints(playerShip.level)
                        if(Int(self.playerData.score) >= requiredPoints){
                            self.playerData.score = Int(self.playerData.score) - requiredPoints
                            playerShip.level++
                            self.updateControls()
                            self.playerData.currentPlayerShip.level = playerShip.level
                        }
                        return
                    }
                    if (self.childNodeWithName("buttonLeftSpeed")!.containsPoint(location)) {
                        if(playerShip.speedAtribute > playerType.speed){
                            playerShip.speedAtribute--
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                    }
                    if (self.childNodeWithName("buttonLeftAcceleration")!.containsPoint(location)) {
                        if(playerShip.acceleration > playerType.acceleration){
                            playerShip.acceleration--
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                    }
                    if (self.childNodeWithName("buttonLeftAgility")!.containsPoint(location)) {
                        if(playerShip.agility > playerType.agility){
                            playerShip.agility--
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                    }
                    if (self.childNodeWithName("buttonLeftArmor")!.containsPoint(location)) {
                        if(playerShip.armor > playerType.armor){
                            playerShip.armor--
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                    }
                    if (self.childNodeWithName("buttonLeftShieldPower")!.containsPoint(location)) {
                        if(playerShip.shieldPower > playerType.shieldPower){
                            playerShip.shieldPower--
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                    }
                    if (self.childNodeWithName("buttonLeftShieldRecharge")!.containsPoint(location)) {
                        if(playerShip.shieldRecharge > playerType.shieldRecharge){
                            playerShip.shieldRecharge--
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                    }
                    
                    if(GameMath.availableUP(playerShip) > 0) {
                        if (self.childNodeWithName("buttonRightSpeed")!.containsPoint(location)) {
                            if(playerShip.speedAtribute < 100){
                                playerShip.speedAtribute++
                            }
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                        if (self.childNodeWithName("buttonRightAcceleration")!.containsPoint(location)) {
                            if(playerShip.acceleration < 100){
                                playerShip.acceleration++
                            }
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                        if (self.childNodeWithName("buttonRightAgility")!.containsPoint(location)) {
                            if(playerShip.agility < 100){
                                playerShip.agility++
                            }
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                        if (self.childNodeWithName("buttonRightArmor")!.containsPoint(location)) {
                            if(playerShip.armor < 100){
                                playerShip.armor++
                            }
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                        if (self.childNodeWithName("buttonRightShieldPower")!.containsPoint(location)) {
                            if(playerShip.shieldPower < 100){
                                playerShip.shieldPower++
                            }
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                        if (self.childNodeWithName("buttonRightShieldRecharge")!.containsPoint(location)) {
                            if(playerShip.shieldRecharge < 100){
                                playerShip.shieldRecharge++
                            }
                            self.updateControls()
                            playerShip.updatePlayerDataCurrentPlayerShip()
                            return
                        }
                    }
                }
                break
                
            default:
                break
            }
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        Control.touchesEnded(self.scene!, touches: touches! as Set<UITouch>)
    }
}
