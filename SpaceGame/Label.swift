//
//  Label.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/26/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class Label: Control {
    
    override func load(name:String, textureName:String, x:Int, y:Int, xAlign:Control.xAlignments, yAlign:Control.yAlignments) {
        if(!name.hasPrefix("label")) {
            fatalError("Error loading Label: \(name). Did you mean label\(name)?")
        }
        self.name = name
        self.sketchPosition = CGPoint(x: x, y: y)
        self.yAlign = yAlign
        self.xAlign = xAlign
        self.zPosition = Config.HUDZPosition/2
        
        let labelNode = SKLabelNode(fontNamed: "Trebuchet MS")
        labelNode.text = textureName
        labelNode.fontSize = 25/2
        labelNode.fontColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        
        labelNode.name = name
        self.addChild(labelNode)
    }
    
    class func resetLabels(scene: SKScene) {
        scene.enumerateChildNodesWithName("label*", usingBlock: { (node:SKNode!, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            (node as! Label).resetPosition()
        })
    }
    
    func setText(text:String){
        let label = self.childNodeWithName(self.name!) as! SKLabelNode
        label.text = text
        label.zPosition = Config.HUDZPosition/2
    }
}
