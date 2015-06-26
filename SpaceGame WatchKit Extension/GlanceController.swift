//
//  GlanceController.swift
//  SpaceGame WatchKit Extension
//
//  Created by Paulo Henrique dos Santos on 22/06/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet weak var imgTop: WKInterfaceImage!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        imgTop.setImageNamed("message")
        
        imgTop.startAnimatingWithImagesInRange(NSMakeRange(0, 50), duration: 2, repeatCount: 4)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
