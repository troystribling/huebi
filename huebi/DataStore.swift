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
    class func getBridge() -> [String:String]? {
        if let storedBridge = NSUserDefaults.standardUserDefaults().dictionaryForKey("bridge") {
            var bridge = [String:String]()
            for (key, val) in storedBridge {
                if let key = key as? String {
                    if let val = val as? String {
                        bridge[key] = val
                    }
                }
            }
            return bridge
        } else {
            return nil
        }
    }
    
    class func setBridge(bridge:[String:String]) {
        NSUserDefaults.standardUserDefaults().setObject(bridge, forKey:"bridge")
    }

}