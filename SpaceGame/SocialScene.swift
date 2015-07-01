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
    var connect = false
    
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
        
        self.addChild(Button(name: "buttonBack", x:81, y:633, xAlign:.left, yAlign:.down))
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) { () -> Void in
            var con = Reachability.isConnectedToNetwork()
            dispatch_async(dispatch_get_main_queue()){
                self.connect = con
                self.inicio()
            }
        }
    }
    
    func buscaPlayers(){
        let query = PFQuery(className: "_User")
        query.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
            if let e = error{
                println(e)
            }
            else{
                var relation  = PFUser.currentUser()!.relationForKey("friends")//pegar favoritos
                relation.query()?.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
                    if let e = error{
                        println(e)
                    }
                    else{
                        self.favoriteArray.addObjectsFromArray(objects!)
                        println(self.favoriteArray.description)
                    }
                })
                
                for user in objects!{
                    if !self.favoriteArray.containsObject(user){
                        if user as? PFUser != PFUser.currentUser(){
                            self.playersArray.addObject(user)
                        }
                    }
                }
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
    
    func sendShip(user:PFObject, data:[NSObject : AnyObject]){
        let objectId = (user["Installation"] as! PFInstallation).objectId
        let pushQuery = PFInstallation.query()
        pushQuery?.whereKey("objectId", equalTo: objectId!)
        var push = PFPush()
        push.setQuery(pushQuery)
        var dict = NSMutableDictionary()
        dict.setObject(data, forKey: "ship")
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
    }
    
    func removeFavorite(user:PFObject){
        var relation = PFUser.currentUser()!.relationForKey("friends")
        relation.removeObject(user)
        PFUser.currentUser()!.saveInBackground()
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
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
    
}
