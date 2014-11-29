//
//  DataStore.swift
//  huebi
//
//  Created by Troy Stribling on 11/20/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import Foundation

class DataStore {
    
    enum BeaconStore : String {
        case selectedBeacons    = "selectedBeacons"
        case configuredBeacons  = "configuredBeacons"
    }
    
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
    class func getBeacons(store:BeaconStore) -> [NSUUID:String] {
        if let storedBeacons = NSUserDefaults.standardUserDefaults().dictionaryForKey(store.rawValue) {
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
    
    class func setBeacons(beacons:[NSUUID:String], store:BeaconStore) {
        var storedBeacons = [String:String]()
        for (uuid, name) in beacons {
            storedBeacons[uuid.UUIDString] = name
        }
        NSUserDefaults.standardUserDefaults().setObject(storedBeacons, forKey:store.rawValue)
    }
    
    class func getBeaconUUIDs(store:BeaconStore) -> [NSUUID] {
        return self.getBeacons(store).keys.array
    }
    
    class func addBeacon(name:String, uuid:NSUUID, store:BeaconStore) {
        var beacons = self.getBeacons(store)
        beacons[uuid] = name
        self.setBeacons(beacons, store:store)
    }
    
    class func removeBeacon(uuid:NSUUID, store:BeaconStore) {
        var beacons = self.getBeacons(store)
        beacons.removeValueForKey(uuid)
        self.setBeacons(beacons, store:store)
    }
    
    class func getBeaconConfigs(store:BeaconStore) -> [NSUUID:[UInt16]] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let storedConfigs = userDefaults.dictionaryForKey(store.rawValue) {
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
    
    class func setBeaconConfigs(configs:[NSUUID:[UInt16]], store:BeaconStore) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var storeConfigs = [String:[NSNumber]]()
        for (uuid, config) in configs {
            storeConfigs[uuid.UUIDString] = [NSNumber(unsignedShort:config[0]), NSNumber(unsignedShort:config[1])]
        }
        userDefaults.setObject(storeConfigs, forKey:store.rawValue)
    }
    
    class func addBeaconConfig(uuid:NSUUID, config:[UInt16], store:BeaconStore) {
        var configs = self.getBeaconConfigs(store)
        configs[uuid] = config
        self.setBeaconConfigs(configs, store:store)
    }
    
    class func getBeaconConfig(uuid:NSUUID, store:BeaconStore) -> [UInt16] {
        let configs = self.getBeaconConfigs(store)
        if let config = configs[uuid] {
            return config
        } else {
            return [0,0]
        }
    }
    
    class func removeBeaconConfig(uuid:NSUUID, store:BeaconStore) {
        var configs = self.getBeaconConfigs(store)
        configs.removeValueForKey(uuid)
        self.setBeaconConfigs(configs, store:store)
    }
    

}