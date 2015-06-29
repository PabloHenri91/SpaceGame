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
        
        if !(Reachability.isConnectedToNetwork()){
            let alert = Alert(text: "Oops! An error occurred while connecting to server.")
            alert.touchesEndedAtButtonOK.addHandler({
                self.view?.presentScene(HangarScene(), transition: SKTransition.crossFadeWithDuration(1))
            })
            self.addChild(alert)
        }else{
            if self.authenticateLocalPlayer(){
                var logou = false
                if(PFUser.currentUser() != nil){ logou = true}
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
                                println(succeeded)
                                if succeeded{
                                    logou = true
                                }
                            })
                        }
                    })
                }
                if logou{
                    
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
                            //relation.addObject(user)//add favorito
                            //array?.removeObject(user)//remover favorito
                            
                            
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
            }
            else{
                // !authenticated
                
            }
        }
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
