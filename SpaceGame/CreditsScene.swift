//
//  CreditsScene.swift
//  SpaceGame
//
//  Created by Gabriel Prado Marcolino on 29/06/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import SpriteKit
import AVFoundation


class creditScene : SKScene{

    enum states {
        
        case mainMenu
        case credits
    }
    
    var sound:AVAudioPlayer = AVAudioPlayer()
    
    var state = states.credits
    var nextState = states.credits
    
    
    override init() {
        Control.locations = NSMutableArray()
        super.init(size: Config.sceneSize())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        
        self.scaleMode = SKSceneScaleMode.AspectFit
        self.backgroundColor = GameColors.gray
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        self.addChild(Control(name: "CreditsBackground", x:0, y:0, align:.center))
        self.addChild(Button(name: "buttonBack", x:81, y:633, xAlign:.left, yAlign:.down))
        
        prepareAudios()
        self.sound.play()
    
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesBegan(self, touches: touches as! Set<UITouch>)
        
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        Control.touchesMoved(self)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        Control.touchesEnded(self, touches: touches as! Set<UITouch>)
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
        
        if (self.childNodeWithName("buttonBack")!.containsPoint(location)) {
            sound.stop()
            self.view!.presentScene(MainMenuScene(), transition: SKTransition.crossFadeWithDuration(1))
            return
            
    }
}
    }
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        Control.touchesEnded(self, touches: touches as! Set<UITouch>)
    }

    func prepareAudios() {
        
        let path = NSBundle.mainBundle().pathForResource("starWars", ofType: "mp3")
        let fileURL = NSURL(fileURLWithPath: path!)
        self.sound = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
        self.sound.prepareToPlay()
        
    }

}
