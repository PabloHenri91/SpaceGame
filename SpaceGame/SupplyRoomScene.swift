//
//  SupplyRoomScene.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/28/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit
import CoreData


class SupplyRoomScene: SKScene {
    
    
    let playerData:PlayerData = GameViewController.memoryCard.playerData!
    override init() {
        Control.locations = NSMutableArray()
        super.init(size: Config.sceneSize())
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "PabloHenri91.SpaceGame" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("SpaceGame", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SpaceGame.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()// Deletar o app e testar de novo. =}
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

    
    var pagina = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        self.scaleMode = SKSceneScaleMode.AspectFit
        self.backgroundColor = GameColors.gray
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        self.addChild(Button(name: "buttonBack", x:28, y:657, xAlign:.left, yAlign:.down))
        
        self.addChild(Control(name: "SupplyBackground", x: 0, y: 0, align:.center))
        
        self.addChild(Button(name: "buttonLeftShips", textureName: "buttonLeft", x: 203, y: 547, align:.center))
        self.addChild(Button(name: "buttonRightShips", textureName: "buttonRight", x: 1053, y: 547, align:.center))
        
        
        
        
        
        
        
        //let playerShip = PlayerShip(playerShipData: self.playerData.currentPlayerShip, x: 670, y: 192, loadPhysics:false)
        let playerShip = PlayerShip(playerShipData: self.playerData.currentPlayerShip, x: 670, y: 192, loadPhysics: false)
        self.addChild(playerShip)
        
        let playerShip0 = PlayerShip(index:(4*pagina+0), x: 385, y: 570)
        playerShip0.name = "playerShip0"
        self.addChild(playerShip0)
        
        let playerShip1 = PlayerShip(index:(4*pagina+1), x: 570, y: 570)
        playerShip1.name = "playerShip1"
        self.addChild(playerShip1)
        
        let playerShip2 = PlayerShip(index:(4*pagina+2), x: 765, y: 570)
        playerShip2.name = "playerShip2"
        self.addChild(playerShip2)
        
        let playerShip3 = PlayerShip(index:(4*pagina+3), x: 950, y: 570)
        playerShip3.name = "playerShip3"
        self.addChild(playerShip3)
        
        println(playerShip0.type)
        
        let playerType = Ships.types[playerShip0.type] as! ShipType
        self.addChild(Label(name:"labelPreco0", textureName:"0", x:340, y:660, align:.center))
        self.addChild(Label(name:"labelPreco1", textureName:"0", x:530, y:660, align:.center))
        self.addChild(Label(name:"labelPreco2", textureName:"0", x:720, y:660, align:.center))
        self.addChild(Label(name:"labelPreco3", textureName:"0", x:910, y:660, align:.center))
        
        
        

        
        self.addChild(Label(name:"labelScore", textureName:"$0", x:267, y:39, align:.center))
        
        self.updateControls()
        
        
    }
    
    func updateControls() {
        
       let playerShip = self.childNodeWithName("player") as! PlayerShip

         
        (self.childNodeWithName("playerShip0") as! PlayerShip).reloadNewShip(4*pagina+0)
        (self.childNodeWithName("playerShip1") as! PlayerShip).reloadNewShip(4*pagina+1)
        (self.childNodeWithName("playerShip2") as! PlayerShip).reloadNewShip(4*pagina+2)
        (self.childNodeWithName("playerShip3") as! PlayerShip).reloadNewShip(4*pagina+3)
        
        
        let playerShip0 = PlayerShip(index:(4*pagina+0), x: 385, y: 570)
        let playerShip1 = PlayerShip(index:(4*pagina+1), x: 570, y: 570)
        let playerShip2 = PlayerShip(index:(4*pagina+2), x: 765, y: 570)
        let playerShip3 = PlayerShip(index:(4*pagina+3), x: 950, y: 570)
        

        
        
        
        
        
        (self.childNodeWithName("labelScore") as! Label).setText("$" + self.playerData.score.description)
        (self.childNodeWithName("labelPreco0") as! Label).setText("$" + self.playerData.score.description)
        (self.childNodeWithName("labelPreco1") as! Label).setText("$" + self.playerData.score.description)
        (self.childNodeWithName("labelPreco2") as! Label).setText("$" + self.playerData.score.description)
        (self.childNodeWithName("labelPreco3") as! Label).setText("$" + self.playerData.score.description)
        
        (self.childNodeWithName("buttonRightShips") as! Button).hidden = pagina == 2
        (self.childNodeWithName("buttonLeftShips") as! Button).hidden = pagina == 0
        
        
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
            
            if (self.childNodeWithName("buttonLeftShips")!.containsPoint(location)) {
                    if (pagina > 0)
                    {
                        pagina--
                        self.updateControls()
                        return
                    }
            }
            
            if (self.childNodeWithName("buttonRightShips")!.containsPoint(location)) {
                    if (pagina < 2)
                    {
                        pagina++
                        self.updateControls()
                        return
                    }
            }
            
            let playerShip = self.childNodeWithName("player") as! PlayerShip
            
            if (self.childNodeWithName("playerShip0")!.containsPoint(location)) {
                
                
                playerShip.reloadNewShip(4*pagina+0)
                
                var playerShipData = NSEntityDescription.insertNewObjectForEntityForName("PlayerShipData", inManagedObjectContext: GameViewController.memoryCard.managedObjectContext!) as! PlayerShipData
                
                playerShipData.shopIndex = 4*pagina+0
                playerShipData.level = 1// nova nave inicia level 1
                
                //Adicionar nave no inventorio do jogador
                //self.playerData.playerShips = NSSet(array: [playerShipData])
                var affs = NSMutableArray()
                for item in self.playerData.playerShips {
                    affs.addObject(item)
                }
                affs.addObject(playerShipData)
                self.playerData.playerShips = NSSet(array: [affs])
                //self.playerData.playerShips = NSSet(array: affs as Array)
                
                println(affs)
                println(self.playerData.playerShips)
                
                //self.playerData.score -=
                    self.playerData.currentPlayerShip = playerShipData
                    //playerShip.reloadNewShip(4*pagina+0)
                    self.updateControls()
                
                    return
                
            }
            
            if (self.childNodeWithName("playerShip1")!.containsPoint(location)) {
                
                playerShip.reloadNewShip(4*pagina+1)
                var playerShipData = NSEntityDescription.insertNewObjectForEntityForName("PlayerShipData", inManagedObjectContext: GameViewController.memoryCard.managedObjectContext!) as! PlayerShipData
                
                playerShipData.shopIndex = 4*pagina+1
                playerShipData.level = 1// nova nave inicia level 1
                
                //Adicionar nave no inventorio do jogador
                //self.playerData.playerShips
                
                //self.playerData.score -=
                self.playerData.currentPlayerShip = playerShipData
                //playerShip.reloadNewShip(4*pagina+0)
                self.updateControls()
                
                return
                
            }
            
            if (self.childNodeWithName("playerShip2")!.containsPoint(location)) {
                
                playerShip.reloadNewShip(4*pagina+2)
                var playerShipData = NSEntityDescription.insertNewObjectForEntityForName("PlayerShipData", inManagedObjectContext: GameViewController.memoryCard.managedObjectContext!) as! PlayerShipData
                
                playerShipData.shopIndex = 4*pagina+2
                playerShipData.level = 1// nova nave inicia level 1
                
                //Adicionar nave no inventorio do jogador
                //self.playerData.playerShips
                
                //self.playerData.score -=
                self.playerData.currentPlayerShip = playerShipData
                //playerShip.reloadNewShip(4*pagina+0)
                self.updateControls()
                
                return
                
            }
            
            
            if (self.childNodeWithName("playerShip3")!.containsPoint(location)) {
                
                playerShip.reloadNewShip(4*pagina+3)
                var playerShipData = NSEntityDescription.insertNewObjectForEntityForName("PlayerShipData", inManagedObjectContext: GameViewController.memoryCard.managedObjectContext!) as! PlayerShipData
                
                playerShipData.shopIndex = 4*pagina+3
                playerShipData.level = 1// nova nave inicia level 1
                
                //Adicionar nave no inventorio do jogador
                //self.playerData.playerShips
                
                //self.playerData.score -=
                self.playerData.currentPlayerShip = playerShipData
                //playerShip.reloadNewShip(4*pagina+0)
                self.updateControls()
                
                return
                
            }

            
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self.scene!, touches: touches as! Set<UITouch>)
    }
}
