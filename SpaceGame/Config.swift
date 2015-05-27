//
//  Config.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/20/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class Config: NSObject {
    
    static var cornflowerBlue:UIColor = UIColor(red: 100/255, green: 149/255, blue: 238/255, alpha: 1)
    static var myBlue:UIColor = UIColor(red: 0/255, green: 88/255, blue: 146/255, alpha: 1)
    static var myGray:UIColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1)
    
    static var tileSize:CGFloat = 64
    static var chunkSize:CGFloat = Config.tileSize * 21// 21 tiles per chunk
    
    static var playerZPosition:CGFloat = 100
    
    static var HUDZPosition:CGFloat = 120
    
    static var skViewBoundsSize:CGSize = CGSizeZero
    
    static var translate:CGPoint = CGPointZero
    
    static func sceneSize() -> CGSize {
        
        let sceneSize:CGSize = CGSize(width: 1334/2, height: 750/2)
        
        let xScale = skViewBoundsSize.width / sceneSize.width
        let yScale = skViewBoundsSize.height / sceneSize.height
        let scale = min(xScale, yScale)
        
        Config.translate = CGPoint(x: ((skViewBoundsSize.width - (sceneSize.width * scale))/2)/scale,
                                   y: ((skViewBoundsSize.height - (sceneSize.height * scale))/2)/scale)
        
        return CGSize(width: skViewBoundsSize.width / scale, height: skViewBoundsSize.height / scale)
    }
    
    enum PhysicsCategory : UInt32 {
        case none   = 0
        case player = 1
        case enemy  = 2
        case bullet = 4
    }
    
    static var playerTypesCount = 13
}
