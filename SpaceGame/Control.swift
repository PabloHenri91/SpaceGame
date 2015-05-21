//
//  Control.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/20/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class Control: SKNode {
    
    enum alignments {
        case center
        case left
        case right
    }
    
    var align = alignments.center {
        didSet {
            self.resetPosition()
        }
    }
    
    var sketchPosition:CGPoint = CGPointZero
    
    static var locations:NSMutableArray = NSMutableArray()
    
    init(name:String, x:Int, y:Int) {
        super.init()
        self.load(name, textureName: name, x: x, y: y, align: alignments.center)
    }
    
    init(name:String, x:Int, y:Int, align:Control.alignments) {
        super.init()
        self.load(name, textureName: name, x: x, y: y, align: align)
    }
    
    init(name:String, textureName:String, x:Int, y:Int) {
        super.init()
        self.load(name, textureName: textureName, x: x, y: y, align: alignments.center)
    }
    
    init(name:String, textureName:String, x:Int, y:Int, align:Control.alignments) {
        super.init()
        self.load(name, textureName: textureName, x: x, y: y, align: align)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(name:String, textureName:String, x:Int, y:Int, align:Control.alignments) {
        self.name = name
        Control.locations.addObject(name)
        self.sketchPosition = CGPoint(x: x, y: y)
        self.align = alignments.center
        
        let texture = SKTexture(imageNamed: textureName)
        let spriteNode = SKSpriteNode(texture: texture, color: nil, size: texture.size())
        spriteNode.anchorPoint = CGPoint(x: 0, y: 1)
        spriteNode.name = name
        self.addChild(spriteNode)
    }
    
    class func resetControls(scene: SKScene) {
        for name in Control.locations {
            ((scene.childNodeWithName(name as! String)) as! Control).resetPosition()
        }
        Button.resetButtons(scene)
        Switch.resetSwitches(scene)
    }
    
    func resetPosition(){
        switch(align)
        {
        case .center:
            self.position = CGPoint(x: Int(sketchPosition.x)/2 + Int(Config.translate.x), y: -Int(sketchPosition.y)/2 - Int(Config.translate.y))
            break
        case .left:
            self.position = CGPoint(x: Int(sketchPosition.x)/2, y: -Int(sketchPosition.y)/2 - Int(Config.translate.y))
            break
        case .right:
            self.position = CGPoint(x: Int(sketchPosition.x)/2 + Int(Config.translate.x * 2), y: -Int(sketchPosition.y)/2 - Int(Config.translate.y))
            break
        default:
            break
        }
    }
}