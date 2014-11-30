//
//  BeaconRanger.swift
//  huebi
//
//  Created by Troy Stribling on 11/29/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import Foundation
import BlueCapKit

class BeaconRanger {
    
    class func start() {
        for (uuid, name) in DataStore.getBeacons(DataStore.BeaconStore.selectedBeacons) {
            let region = BeaconRegion(proximityUUID:uuid, identifier:name) {(beaconRegion) in
                beaconRegion.startMonitoringRegion = {
                    BeaconManager.sharedInstance.startRangingBeaconsInRegion(beaconRegion)
                    Logger.debug("BeaconRegionsViewController#startMonitoring: started monitoring region \(name)")
                }
                beaconRegion.enterRegion = {
                    if !BeaconManager.sharedInstance.isRangingRegion(beaconRegion.identifier) {
                        BeaconManager.sharedInstance.startRangingBeaconsInRegion(beaconRegion)
                    }
                    Notify.withMessage("Entering region '\(name)'. Started ranging beacons.")
                }
                beaconRegion.exitRegion = {
                    BeaconManager.sharedInstance.stopRangingBeaconsInRegion(beaconRegion)
                    Notify.withMessage("Exited region '\(name)'. Stoped ranging beacons.")
                }
                beaconRegion.errorMonitoringRegion = {(error) in
                    BeaconManager.sharedInstance.stopRangingBeaconsInRegion(beaconRegion)
                }
                beaconRegion.rangedBeacons = {(beacons) in
                    for beacon in beacons {
                        Logger.debug("major:\(beacon.major), minor: \(beacon.minor), rssi: \(beacon.rssi)")
                    }
                }
            }
            BeaconManager.sharedInstance.startMonitoringForRegion(region)
        }
    }
    
}