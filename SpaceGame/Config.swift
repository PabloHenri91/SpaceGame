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
    static var chunkSize:CGFloat = Config.tileSize * CGFloat(MapManager.tilesPerChunk)
    
    static var playerZPosition:CGFloat = 100
    
    static var HUDZPosition:CGFloat = 120
    
    static var skViewBoundsSize:CGSize = CGSizeZero
    
    static var translate:CGPoint = CGPointZero
    
    static func sceneSize() -> CGSize {
        
        if(UIDevice.currentDevice().systemVersion.hasPrefix("8")) {
            let sceneSize:CGSize = CGSize(width: 1334/2, height: 750/2)
            
            let xScale = skViewBoundsSize.width / sceneSize.width
            let yScale = skViewBoundsSize.height / sceneSize.height
            var scale = min(xScale, yScale)
            
            Config.translate = CGPoint(x: ((skViewBoundsSize.width - (sceneSize.width * scale))/2)/scale,
                                       y: ((skViewBoundsSize.height - (sceneSize.height * scale))/2)/scale)
            
            return CGSize(width: skViewBoundsSize.width / scale, height: skViewBoundsSize.height / scale)
        } else {
            //TODO: caculo de translate causa comportamento estranho no iOS 7
            var scale = 1
            
            Config.translate = CGPoint.zeroPoint
            
            return CGSize(width: 1334/2, height: 750/2)
            
        }
    }
    
    //GamePlay
    static var spawningInterval:Double = 1
    
    enum PhysicsCategory : UInt32 {
        case none   = 0
        case player = 1
        case enemy  = 2
        case bullet = 4
    }
    
    static var playerTypesCount = 7
}
