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
    class func getBeacons(key:String = "foundBeacons") -> [NSUUID:String] {
        if let storedBeacons = NSUserDefaults.standardUserDefaults().dictionaryForKey(key) {
            var beacons = [NSUUID:String]()
            for (uuid, name) in storedBeacons {
                if let name = name as? String {
                    if let uuid = uuid as? String {
                        if let nsuuid = NSUUID(UUIDString:uuid) {
                            beacons[nsuuid] = name
                        }
                    }
                }
            }
            return beacons
        } else {
            return [:]
        }
    }
    
    class func setBeacons(beacons:[NSUUID:String], key:String = "foundBeacons") {
        var storedBeacons = [String:String]()
        for (uuid, name) in beacons {
            storedBeacons[uuid.UUIDString] = name
        }
        NSUserDefaults.standardUserDefaults().setObject(storedBeacons, forKey:key)
    }
    
    class func getBeaconUUIDs(key:String = "foundBeacons") -> [NSUUID] {
        return self.getBeacons(key:key).keys.array
    }
    
    class func addBeacon(name:String, uuid:NSUUID, key:String = "foundBeacons") {
        var beacons = self.getBeacons()
        beacons[uuid] = name
        self.setBeacons(beacons)
    }
    
    class func removeBeacon(uuid:NSUUID) {
        var beacons = self.getBeacons()
        beacons.removeValueForKey(uuid)
        self.setBeacons(beacons)
    }
    
    class func getBeaconConfigs(key:String = "foundBeacons") -> [NSUUID:[UInt16]] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let storedConfigs = userDefaults.dictionaryForKey(key) {
            var configs = [NSUUID:[UInt16]]()
            for (uuid, config) in storedConfigs {
                if let uuid = uuid as? String {
                    if let nsuuid =  NSUUID(UUIDString:uuid) {
                        if config.count == 2 {
                            let minor = config[0] as NSNumber
                            let major = config[1] as NSNumber
                            configs[nsuuid] = [minor.unsignedShortValue, major.unsignedShortValue]
                        }
                    }
                }
            }
            return configs
        } else {
            return [:]
        }
    }
    
    class func setBeaconConfigs(configs:[NSUUID:[UInt16]], key:String = "foundBeacons") {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var storeConfigs = [String:[NSNumber]]()
        for (uuid, config) in configs {
            storeConfigs[uuid.UUIDString] = [NSNumber(unsignedShort:config[0]), NSNumber(unsignedShort:config[1])]
        }
        userDefaults.setObject(storeConfigs, forKey:key)
    }
    
    class func addBeaconConfig(uuid:NSUUID, config:[UInt16], key:String = "foundBeacons") {
        var configs = self.getBeaconConfigs(key:key)
        configs[uuid] = config
        self.setBeaconConfigs(configs)
    }
    
    class func getBeaconConfig(uuid:NSUUID, key:String = "foundBeacons") -> [UInt16] {
        let configs = self.getBeaconConfigs(key:key)
        if let config = configs[uuid] {
            return config
        } else {
            return [0,0]
        }
    }
    
    class func removeBeaconConfig(uuid:NSUUID, key:String = "foundBeacons") {
        var configs = self.getBeaconConfigs(key:key)
        configs.removeValueForKey(uuid)
        self.setBeaconConfigs(configs)
    }
    

}