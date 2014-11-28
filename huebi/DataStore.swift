//
//  DataStore.swift
//  huebi
//
//  Created by Troy Stribling on 11/20/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import Foundation

class DataStore {
    
    // Bridge
    class func getBridges() -> [String:String] {
        if let storedBridge = NSUserDefaults.standardUserDefaults().dictionaryForKey("bridges") {
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
            return [:]
        }
    }
    
    class func setBridges(bridges:[String:String]) {
        NSUserDefaults.standardUserDefaults().setObject(bridges, forKey:"bridges")
    }
    
    class func addBridge(bridge:JSON) {
        if let ipAddress = bridge["internalipaddress"].string {
            if let name = bridge["name"].string {
                self.addBridge(name, ipAddress:ipAddress)
            }
        }
    }
    
    class func addBridge(name:String, ipAddress:String) {
        var bridges = self.getBridges()
        bridges[ipAddress] = name
        self.setBridges(bridges)
    }
    
    class func getSelectedBridge() -> String? {
         return NSUserDefaults.standardUserDefaults().stringForKey("selectedBridge")
    }
    
    class func setSelectedBridge(ipAddress:String) {
        NSUserDefaults.standardUserDefaults().setObject(ipAddress, forKey:"selectedBridge")
    }

    class func getUsername() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey("username")
    }
    
    class func setUsername(username:String) {
        NSUserDefaults.standardUserDefaults().setObject(username, forKey:"username")
    }
    

    // Beacons
    class func getBeacons() -> [String:NSUUID] {
        if let storedBeacons = NSUserDefaults.standardUserDefaults().dictionaryForKey("peripheralBeacons") {
            var beacons = [String:NSUUID]()
            for (name, uuid) in storedBeacons {
                if let name = name as? String {
                    if let uuid = uuid as? String {
                        beacons[name] = NSUUID(UUIDString:uuid)
                    }
                }
            }
            return beacons
        } else {
            return [:]
        }
    }
    
    class func setBeacons(beacons:[String:NSUUID]) {
        var storedBeacons = [String:String]()
        for (name, uuid) in beacons {
            storedBeacons[name] = uuid.UUIDString
        }
        NSUserDefaults.standardUserDefaults().setObject(storedBeacons, forKey:"peripheralBeacons")
    }
    
    class func getBeaconNames() -> [String] {
        return self.getBeacons().keys.array
    }
    
    class func addBeacon(name:String, uuid:NSUUID) {
        var beacons = self.getBeacons()
        beacons[name] = uuid
        self.setBeacons(beacons)
    }
    
    class func removeBeacon(name:String) {
        var beacons = self.getBeacons()
        beacons.removeValueForKey(name)
        self.setBeacons(beacons)
    }
    
    class func getBeacon(name:String) -> NSUUID? {
        let beacons = self.getBeacons()
        return beacons[name]
    }
    
    class func getBeaconConfigs() -> [String:[UInt16]] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let storedConfigs = userDefaults.dictionaryForKey("peipheralBeaconConfigs") {
            var configs = [String:[UInt16]]()
            for (name, config) in storedConfigs {
                if let name = name as? String {
                    if config.count == 2 {
                        let minor = config[0] as NSNumber
                        let major = config[1] as NSNumber
                        configs[name] = [minor.unsignedShortValue, major.unsignedShortValue]
                    }
                }
            }
            return configs
        } else {
            return [:]
        }
    }
    
    class func setBeaconConfigs(configs:[String:[UInt16]]) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var storeConfigs = [String:[NSNumber]]()
        for (name, config) in configs {
            storeConfigs[name] = [NSNumber(unsignedShort:config[0]), NSNumber(unsignedShort:config[1])]
        }
        userDefaults.setObject(storeConfigs, forKey:"peipheralBeaconConfigs")
    }
    
    class func addBeaconConfig(name:String, config:[UInt16]) {
        var configs = self.getBeaconConfigs()
        configs[name] = config
        self.setBeaconConfigs(configs)
    }
    
    class func getBeaconConfig(name:String) -> [UInt16] {
        let configs = self.getBeaconConfigs()
        if let config = configs[name] {
            return config
        } else {
            return [0,0]
        }
    }
    
    class func removeBeaconConfig(name:String) {
        var configs = self.getBeaconConfigs()
        configs.removeValueForKey(name)
        self.setBeaconConfigs(configs)
    }
    

}