//
//  InterfaceController.swift
//  SpaceGame WatchKit Extension
//
//  Created by Paulo Henrique dos Santos on 22/06/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var lblFrase: WKInterfaceLabel!
    
    var frases: [String] = ["Vida longa e próspera - Startrek", "Que a força esteja com você. - Star wars", "Luke, eu sou seu pai - Darth vader", "woowrrororworoworwworrwor - Chewbacca","Um pequeno passo para um homem, um salto gigantesco para a humanidade - Neil Armstrong","Nao entre em pânico - O guia do mochileiro das galáxias"]

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
//        lblFrase.setText(frases[0] as String)
        
        self.updateText()
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

    @IBAction func btnUpdate() {
        self.updateText()
    }
    
    func updateText()
    {
        let randomIndex = Int(arc4random_uniform(UInt32(frases.count)))
        self.lblFrase.setText(self.frases[randomIndex])
    }
    
}
