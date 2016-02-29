//
//  Shot.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 7/2/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {
    
    var dx:CGFloat = 0
    var dy:CGFloat = 0
    
    init(position:CGPoint, zRotation:CGFloat) {
        let texture = SKTexture(imageNamed: "shot")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.dx = -sin(zRotation)
        self.dy = cos(zRotation)
        self.position = CGPoint(x:position.x + (dx * 64), y:position.y + (dy * 64))
        self.physicsBody = SKPhysicsBody(circleOfRadius: texture.size().height)
        
        self.name = "shot"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        self.physicsBody?.applyForce(CGVector(dx: dx * 1000, dy: dy * 1000))
    }
}
