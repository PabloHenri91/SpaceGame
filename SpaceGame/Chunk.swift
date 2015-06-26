//
//  Chunk.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 6/24/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit

class Chunk: SKSpriteNode {
    init(regionX:Int, regionY:Int) {
        let texture = SKTexture(imageNamed: "chunkBackground0")
        super.init(texture: texture, color: nil, size: CGSize(width: Config.chunkSize, height: Config.chunkSize))
        self.anchorPoint = CGPointZero
        self.load(regionX, regionY: regionY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeAllChildren() {
        dispatch_async(dispatch_get_main_queue()) {
            super.removeAllChildren()
        }
    }
    
    func loadData(data: NSArray){
        var i = 0
        var tiles:NSMutableArray = NSMutableArray()
        for (var y = 0; y < MapManager.tilesPerChunk; y++) {
            for (var x = 0; x <  MapManager.tilesPerChunk; x++) {
                if(data[i].integerValue != 0) {
                    var tile = Meteor(id: data[i].integerValue, x:x, y:y)
                    
                    //MapManager.loading é setado para true durante o update do MapManager. No carregamento inicial seu valor é false
                    if(MapManager.loading) {
                        tiles.addObject(tile)
                    } else {
                        self.addChild(tile)
                    }
                }
                i++
            }
        }
        
        if(MapManager.loading){
            dispatch_async(dispatch_get_main_queue()) {
                for tile in tiles {
                    self.addChild(tile as! SKNode)
                }
            }
        }
    }
    
    func load(regionX:Int, regionY:Int) {
        
        self.position = CGPoint(x: self.size.width * (CGFloat)(regionX),
            y: self.size.height * (CGFloat)(regionY))
        
        
        switch ("\(regionX) \(regionY)") {
            
//        case "0 -1":
//            self.loadData([0,0])
//            break
            
        default:
            var data:NSMutableArray = NSMutableArray()
            for (var i = 0; i <  MapManager.tilesPerChunk * MapManager.tilesPerChunk; i++) {
                if(arc4random_uniform(1000) <= 1) {
                    var randomTile =  Int(arc4random_uniform(UInt32(MapManager.meteorTypeCount)))
                    data.addObject(randomTile)
                } else {
                    data.addObject(0)
                }
            }
            self.loadData(data)
            break
        }
    }
}