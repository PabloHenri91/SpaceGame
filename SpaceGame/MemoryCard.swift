//
//  MemoryCard.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/22/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit

class MemoryCard: NSObject {
    let path = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as! String) + "/data.plist"
    
    let fileManager = NSFileManager.defaultManager()
    
    var save:NSMutableDictionary = NSMutableDictionary()
    
    var playerShips:NSMutableDictionary = NSMutableDictionary()
    var playerShipIndex:Int = 0
    
    func newGame(shipIndex:Int) {
        self.save.setObject(self.playerShips, forKey: "playerShips")
        self.playerShips.setObject(NSMutableDictionary(), forKey: shipIndex)
        self.playerShipIndex = shipIndex
    }
    
    func saveGame() {
        if(self.fileManager.fileExistsAtPath(self.path)){
            self.save.writeToFile(self.path, atomically: true)
        } else {
            fileManager.createFileAtPath(self.path, contents: nil, attributes: nil)
            self.save.writeToFile(path, atomically: true)
        }
    }
    
    func loadGame() -> Bool {
        if(self.fileManager.fileExistsAtPath(self.path)) {
            self.save = NSMutableDictionary(contentsOfFile: self.path)!
            return true
        } else {
            return false
        }
    }
    
    func loadFromMainBundle() -> Bool {
        let bundle:String = NSBundle.mainBundle().pathForResource("data", ofType: "plist")!
        self.fileManager.copyItemAtPath(bundle, toPath: self.path, error:nil)
        return self.loadGame()
    }
    
    func reset(){
        var error:NSError?
        
        self.fileManager.removeItemAtPath(self.path, error: &error)
        
        if error != nil {
            println(error)
        }
    }
}
