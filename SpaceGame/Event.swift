//
//  Event.swift
//  SpaceGame
//
//  Created by Pablo Henrique Bertaco on 5/28/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit

class Event<T> : NSObject {
    
    typealias EventHandler = T -> ()
    
    private var eventHandlers = [EventHandler]()
    
    func addHandler(handler: EventHandler) {
        eventHandlers.append(handler)
    }
    
    func raise(data: T) {
        for handler in eventHandlers {
            handler(data)
        }
    }
}

