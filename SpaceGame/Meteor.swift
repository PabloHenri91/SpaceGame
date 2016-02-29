//
//  Tile.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/24/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class Meteor: SKSpriteNode {
    init(id:Int, x:Int, y:Int) {
        let texture = SKTexture(imageNamed: "meteor\(id)")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.position = CGPoint(x: x * (Int)(Config.tileSize), y: y * -(Int)(Config.tileSize) + (Int)(Config.chunkSize - Config.tileSize))
        
        self.physicsBody = SKPhysicsBody(bodies: [MapManager.bodies[id]])
        
        self.physicsBody!.angularDamping = 1
        self.physicsBody!.linearDamping = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
