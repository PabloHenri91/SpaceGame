//
//  Audio.swift
//  SpaceGame
//
//  Created by Gabriel Prado Marcolino on 01/07/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import Foundation
import AVFoundation

class Audio{
    
    static var sound : AVAudioPlayer!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func prepareAudios(name:String) {
        
        
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "mp3")
        let fileURL = NSURL(fileURLWithPath: path!)
        Audio.sound = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
        Audio.sound.prepareToPlay()
        Audio.sound.numberOfLoops = -1
        Audio.sound.volume = 1
        Audio.sound.play()
        
    }
    
    class func stopAudio(name:String){
        
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "mp3")
        let fileURL = NSURL(fileURLWithPath: path!)
        Audio.sound = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
        Audio.sound.stop()
    
    }
    
    
}