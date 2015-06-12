//
//  Config.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/20/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class Config: NSObject {
    
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
        
        
        if(UIDevice.currentDevice().systemVersion.hasPrefix("8")) {
            Config.translate = CGPoint(x: ((skViewBoundsSize.width - (sceneSize.width * scale))/2)/scale,
                                       y: ((skViewBoundsSize.height - (sceneSize.height * scale))/2)/scale)
        } else {
            //TODO: caculo de translate causa comportamento estranho no iOS 7
            Config.translate = CGPoint.zeroPoint
        }
        
        println(skViewBoundsSize)
        
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
