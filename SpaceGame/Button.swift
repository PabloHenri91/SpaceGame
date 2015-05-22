//
//  Button.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/20/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit
import SpriteKit

class Button: Control {
    
    var pressed:Bool = false
    
    override func load(name:String, textureName:String, x:Int, y:Int, align:Control.alignments) {
        if(!name.hasPrefix("button")) {
            fatalError("Error loading Button: \(name). Did you mean button\(name)?")
        }
        self.name = name
        self.sketchPosition = CGPoint(x: x, y: y)
        self.align = align
        self.zPosition = Config.HUDZPosition
        
        let texture = SKTexture(imageNamed: textureName)
        let button = SKSpriteNode(texture: texture, color: nil, size: texture.size())
        button.anchorPoint = CGPoint(x: 0, y: 1)
        button.name = name
        self.addChild(button)
        
        let texturePressed = SKTexture(imageNamed: "\(textureName)Pressed")
        let buttonPressed = SKSpriteNode(texture: texturePressed, color: nil, size: texturePressed.size())
        buttonPressed.name = "\(name)Pressed"
        buttonPressed.anchorPoint = CGPoint(x: 0, y: 1)
        buttonPressed.hidden = true
        self.addChild(buttonPressed)
    }
    
    class func resetButtons(scene: SKScene) {
        scene.enumerateChildNodesWithName("button*", usingBlock: { (node:SKNode!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            (node as! Button).resetPosition()
        })
    }
    
    class func touchesBegan(scene: SKNode, touches: Set<UITouch>) {
        scene.enumerateChildNodesWithName("button*", usingBlock: { (node:SKNode!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            for touch in touches {
                let location = touch.locationInNode(node.parent)
                if node.containsPoint(location) {
                    (node as! Button).buttonPressed()
                }
            }
        })
    }
    
    class func touchesMoved(scene: SKNode, touches: Set<UITouch>) {
        scene.enumerateChildNodesWithName("button*", usingBlock: { (node:SKNode!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            (node as! Button).buttonReleased()
            for touch in touches {
                let location = touch.locationInNode(node.parent)
                if node.containsPoint(location) {
                    (node as! Button).buttonPressed()
                }
            }
        })
    }
    
    class func touchesEnded(scene: SKNode, touches: Set<UITouch>) {
        scene.enumerateChildNodesWithName("button*", usingBlock: { (node:SKNode!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            for touch in touches {
                let location = touch.locationInNode(node.parent)
                if node.containsPoint(location) {
                    (node as! Button).buttonReleased()
                }
            }
        })
    }
    
    private func buttonPressed() {
        self.pressed = true
        self.childNodeWithName(self.name!)!.hidden = true
        self.childNodeWithName("\(self.name!)Pressed")!.hidden = false
    }
    
    private func buttonReleased() {
        self.pressed = false
        self.childNodeWithName(self.name!)!.hidden = false
        self.childNodeWithName("\(self.name!)Pressed")!.hidden = true
    }
}
