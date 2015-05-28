//
//  MemoryCard.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/22/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit

class MemoryCard: NSObject {
    
    var autoSave:Bool = false
    
    let path = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as! String) + "/data.plist"
    let fileManager = NSFileManager.defaultManager()
    
    var save:NSMutableDictionary = NSMutableDictionary()
    
    var playerShipSelected:Int {
        get {
            return self.save.objectForKey("playerShipSelected")!.integerValue
        }
        set(value) {
            self.save.setObject(value, forKey: "playerShipSelected")
        }
    }
    
    func newGame(shipIndex:Int) {
        self.save.setObject(NSArray(array: [shipIndex]), forKey: "playerShips")
        self.save.setObject(shipIndex, forKey: "playerShipSelected")
        
        self.autoSave = true
        
        self.saveGame()
    }
    
    func saveGame() {
        if(self.autoSave){
            if(self.fileManager.fileExistsAtPath(self.path)){
                self.save.writeToFile(self.path, atomically: true)
            } else {
                fileManager.createFileAtPath(self.path, contents: nil, attributes: nil)
                self.save.writeToFile(self.path, atomically: true)
            }
            println("Saving game at " + self.path)
        }
    }
    
    func loadGame() -> Bool {
        if(self.fileManager.fileExistsAtPath(self.path)) {
            println("Loading game from " + self.path)
            self.save = NSMutableDictionary(contentsOfFile: self.path)!
            
            self.autoSave = true
            return true
        } else {
            return false
        }
    }
    
//    func loadFromMainBundle() -> Bool {
//        let bundle:String = NSBundle.mainBundle().pathForResource("data", ofType: "plist")!
//        self.fileManager.copyItemAtPath(bundle, toPath: self.path, error:nil)
//        return self.loadGame()
//    }
    
    func reset(){
        println("MemoryCard.reset()")
        var error:NSError?
        
        self.fileManager.removeItemAtPath(self.path, error: &error)
        
        self.autoSave = false
        
        if error != nil {
            println(error)
        }
    }
}
