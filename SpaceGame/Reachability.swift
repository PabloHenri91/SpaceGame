//
//  Reachability.swift
//  SpaceGame
//
//  Created by Uriel on 24/06/15.
//  Copyright (c) 2015 WTFGames. All rights reserved.
//

import UIKit

class Reachability: NSObject {
    class func isConnectedToNetwork() -> Bool {
        var status:Bool = false
            let url = NSURL(string: "http://google.com")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "HEAD"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
            request.timeoutInterval = 10.0
            
            var response:NSURLResponse?
            
            var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    status = true
                }
            }
        return status
    }
}
