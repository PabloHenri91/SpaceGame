//
//  MemoryCard.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/22/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit

class MemoryCard: NSObject {
    
    var save:NSMutableDictionary = NSMutableDictionary()
    
    //
    var playerShips:NSMutableDictionary = NSMutableDictionary()
    var playerShipIndex:Int = 0
    
    func newGame(shipIndex:Int) {
        save.setObject(playerShips, forKey: "playerShips")
        self.playerShips.setObject(NSMutableDictionary(), forKey: shipIndex)
        self.playerShipIndex = shipIndex
    }
    
    func saveGame() {
        
    }
    
    func loadGame() -> Bool {
        return false
    }
}
