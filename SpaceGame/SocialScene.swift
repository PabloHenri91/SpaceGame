//
//  SocialScene.swift
//  SpaceGame
//
//  Created by Uriel on 24/06/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit
import Parse
import GameKit

class SocialScene: SKScene {
    
    var localPlayer = GKLocalPlayer.localPlayer()
    var playersArray = NSMutableArray()
    var favoriteArray = NSMutableArray()
    let playerData:PlayerData = GameViewController.memoryCard.playerData!
    var connect = false
    var indexShip =  0;
    var shipArray = NSMutableArray()
    var labelIndex = NSMutableArray()
    
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
        
        self.addChild(Button(name: "buttonBack", x:28, y:657, xAlign:.left, yAlign:.down))
        self.addChild(Control(name: "socialBackground", x: 0, y: 0, align:.center))
        self.addChild(Button(name: "buttonLeftShips", textureName: "buttonLeft", x: 250, y: 452, align:.center))
        self.addChild(Button(name: "buttonRightShips", textureName: "buttonRight", x: 385, y: 452, align:.center))
        
        let playerShip = PlayerShip(index:(self.playerData.currentPlayerShip.shopIndex as Int), x: 356, y: 325)
        
        playerShip.name = "playerShip"
        self.addChild(playerShip)
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) { () -> Void in
            var con = Reachability.isConnectedToNetwork()
            dispatch_async(dispatch_get_main_queue()){
                self.connect = con
                self.inicio()
            }
        }
        for ship in self.playerData.playerShips{
            shipArray.addObject(ship.shopIndex)
        }
    }
    
    func addPlayersScene(){
        var y = 73
        var i = 0
        for user in self.favoriteArray{
            if let name = user.username!{
                var label = (Label(name:"label\(i)", textureName:"\(name)", x:637, y:y+35, align:.center))
                (label.childNodeWithName("label\(i)") as! SKLabelNode).horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
                var switch1 = (Switch(name: "switch\(name)", textureName: "switchFavorite", x: 1106, y: y+8, align: .center))
                switch1.switchPressed()
                self.addChild(switch1)
                self.addChild(label)
                self.addChild(Control(name: "control\(i)", textureName: "bordaPlayers", x: 598, y: y))
                y += 75
                self.labelIndex.addObject(i)
                i++
            }
        }
        for user in self.playersArray{
            if let name = user.username!{
                var label = Label(name:"label\(i)", textureName:"\(name)", x:637, y:y+35, align:.center)
                (label.childNodeWithName("label\(i)") as! SKLabelNode).horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
                self.addChild(Switch(name: "switch\(name)", textureName: "switchFavorite", x: 1106, y: y+8, align: .center))
                self.addChild(label)
                self.addChild(Control(name: "control\(i)", textureName: "bordaPlayers", x: 598, y: y))
                y += 75
                self.labelIndex.addObject(i)
                i++
            }
        }
    }
    
    
    func buscaPlayers(){
        var relation  = PFUser.currentUser()!.relationForKey("friends")//pegar favoritos
        relation.query()?.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
            if let e = error{
                println(e)
            }
            else{
                self.favoriteArray.addObjectsFromArray(objects!)
                let query = PFQuery(className: "_User")
                query.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
                    if let e = error{
                        println(e)
                    }
                    else{
                        
                        for user in objects!{
                            var contains = false
                            for favorite in self.favoriteArray{
                                if user.objectId == favorite.objectId{
                                    contains = true
                                    break
                                }
                            }
                            if !contains{
                                if (user as! PFUser).username!  != PFUser.currentUser()!.username!{
                                    self.playersArray.addObject(user)
                                }
                            }
                        }
                        self.addPlayersScene()
                    }
                })
            }
        })
    }
    
    func inicio(){
        if self.connect {
            if self.authenticateLocalPlayer(){
                var logou = false
                
                if PFUser.currentUser() != nil{
                    logou = true
                }
                else{
                    PFUser.logInWithUsernameInBackground(self.localPlayer.displayName, password: "123", block: { (user, error) -> Void in
                        if let usr = user{
                            logou = true
                        }
                        else if (error != nil){
                            let user = PFUser()
                            user.username = self.localPlayer.displayName
                            user.password = "123"
                            user["Installation"] = PFInstallation.currentInstallation()
                            user.signUpInBackgroundWithBlock({ (succeeded, error) -> Void in
                                if succeeded{
                                    logou = true
                                }
                                else{
                                    println(error)
                                }
                            })
                        }
                    })
                }
                if logou{
                    self.buscaPlayers()
                }
            }
            else{
                // !authenticated
                
            }
        }
        else{
            let alert = Alert(text: "Oops! An error occurred while connecting to server.")
            alert.touchesEndedAtButtonOK.addHandler({
                self.view?.presentScene(HangarScene(), transition: SKTransition.crossFadeWithDuration(1))
            })
            self.addChild(alert)
        }
    }
    
    func sendShip(user:PFObject/*, data:[NSObject : AnyObject]*/){
        let objectId = (user["Installation"] as! PFInstallation).objectId
        let pushQuery = PFInstallation.query()
        pushQuery?.whereKey("objectId", equalTo: objectId!)
        var push = PFPush()
        push.setQuery(pushQuery)
        var dict = NSMutableDictionary()
        //dict.setObject(data, forKey: "ship")
        if let name = PFUser.currentUser()!.username{
            dict.setObject("\(name) send a ship", forKey: "alert")
        }
        push.setData(dict as [NSObject : AnyObject])
        push.sendPushInBackground()
    }
    
    func addFavorite(user:PFObject){
        var relation = PFUser.currentUser()!.relationForKey("friends")
        relation.addObject(user)
        PFUser.currentUser()!.saveInBackground()
        var switch1 = (self.childNodeWithName("switch\((user as! PFUser).username!)") as! Switch)
        switch1.switchPressed()
        self.playersArray.removeObject(user)
        self.favoriteArray.addObject(user)
    }
    
    func removeFavorite(user:PFObject){
        var relation = PFUser.currentUser()!.relationForKey("friends")
        relation.removeObject(user)
        PFUser.currentUser()!.saveInBackground()
        var switch1 = (self.childNodeWithName("switch\((user as! PFUser).username!)") as! Switch)
        switch1.switchPressed()
        self.favoriteArray.removeObject(user)
        self.playersArray.addObject(user)
    }
    
    func authenticateLocalPlayer()->Bool{
        var authenticated = false
        self.localPlayer.authenticateHandler = {(viewController : UIViewController!, error : NSError!) -> Void in
            
            if viewController != nil{
                //method that displays an authentication view when appropriate for your app
            }
            else{
                if self.localPlayer.authenticated {
                    authenticated = true
                }
            }
        }
        
        return true//depois trocar para authenticated
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
                self.view?.presentScene(HangarScene(), transition: SKTransition.crossFadeWithDuration(1))
                return
            }
            if (self.childNodeWithName("buttonLeftShips")!.containsPoint(location)){
                if(self.indexShip == 0){
                    self.indexShip = self.shipArray.count-1
                }
                else{
                    self.indexShip--
                    
                }
                
                (self.childNodeWithName("playerShip") as! PlayerShip).reloadNewShip(self.shipArray[indexShip] as! Int)
            }
            if (self.childNodeWithName("buttonRightShips")!.containsPoint(location)){
                if(self.indexShip == self.shipArray.count-1){
                    self.indexShip = 0
                }
                else{
                    self.indexShip++
                    
                }
                (self.childNodeWithName("playerShip") as! PlayerShip).reloadNewShip(self.shipArray[indexShip] as! Int)
            }
            for i in self.labelIndex{
                if(self.childNodeWithName("control\(i)")!.containsPoint(location)){
                    
                    let menu = MenuSocial(text: "")
                    menu.touchesEndedAtButtonFavorite.addHandler({
                        var flag = false
                        for user in self.favoriteArray{
                            if user.username! == (self.childNodeWithName("label\(i)") as! Label).getText(){
                                self.removeFavorite(user as! PFObject)
                                flag = true
                                break
                            }
                        }
                        if(!flag){
                            for user in self.playersArray{
                                if user.username! == (self.childNodeWithName("label\(i)") as! Label).getText(){
                                    self.addFavorite(user as! PFObject)
                                }
                            }
                        }
                    })
                    menu.touchesEndedAtButtonSendShip.addHandler({
                        var flag = false
                        var player = PFObject(className: "User")
                        for user in self.favoriteArray{
                            if user.username! == (self.childNodeWithName("label\(i)") as! Label).getText(){
                                player = user as! PFObject
                                flag = true
                                break
                            }
                        }
                        if(!flag){
                            for user in self.playersArray{
                                if user.username! == (self.childNodeWithName("label\(i)") as! Label).getText(){
                                    player = user as! PFObject
                                }
                            }
                        }
                        self.sendShip(player)
                    })
                    self.addChild(menu)
                }
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
    
}
