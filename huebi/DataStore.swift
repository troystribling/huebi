//
//  DataStore.swift
//  huebi
//
//  Created by Troy Stribling on 11/20/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import Foundation

class DataStore {
    
    // Bridge IP Address
    class func getBridgeIpAddress() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey("bridgeIPAddress")
    }
    
    class func setBridgeIpAddress(ipAddress:String) {
        NSUserDefaults.standardUserDefaults().setObject(ipAddress, forKey:"bridgeIPAddress")
    }

}