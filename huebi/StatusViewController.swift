//
//  StatusViewController.swift
//  huebi
//
//  Created by Troy Stribling on 11/23/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit
import BlueCapKit

class StatusViewController: UIViewController {

    var bridges : JSON?
    
    struct MainStoryboard {
        static let bridgeConnectSegue   = "BridgeConnectStatus"
        static let foundBridgesSegue    = "FoundBridges"
        static let bridgesSegue         = "Bridges"
        static let beaconsSegue         = "Beacons"
        static let noBridgeFoundSegue   = "NoBridgeFound"
        static let foundBeaconsSegue    = "FoundBeacons"
    }
    
    struct Beacon {
        let uuid : NSUUID
        let name : String
    }
    
    let defaultBeacons = [Beacon(uuid:NSUUID(UUIDString:"B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, name:"estimote")]
    
    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated:Bool) {
        super.viewWillAppear(animated)
        if DataStore.getSelectedBridge() == nil {
            HueClient.discoverBridge({(data) in
                Logger.debug("StatusViewController#viewDidLoad bridgeQueryResponse: \(data)")
                if data.count == 0 {
                    self.performSegueWithIdentifier(MainStoryboard.noBridgeFoundSegue, sender:self)
                } else if data.count == 1 {
                    self.bridges = data
                    if let ipaddress = data[0]["internalipaddress"].string {
                        Logger.debug("StatusViewController#viewDidLoad: selected bridge: \(ipaddress)")
                        DataStore.addBridge(data[0])
                        self.performSegueWithIdentifier(MainStoryboard.bridgeConnectSegue, sender:self)
                    }
                } else {
                    self.performSegueWithIdentifier(MainStoryboard.bridgesSegue, sender:self)
                }
                }, discoveyFailed:{(error) in
                    self.performSegueWithIdentifier(MainStoryboard.noBridgeFoundSegue, sender:self)
            })
        }
        if DataStore.getBeacons(DataStore.BeaconStore.selectedBeacons).isEmpty {
            self.addDefaultBeacons()
            self.performSegueWithIdentifier(MainStoryboard.foundBeaconsSegue, sender: self)
        }
    }
    
    override func viewDidDisappear(animated:Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func prepareForSegue(segue:UIStoryboardSegue, sender:AnyObject?) {
        if segue.identifier == MainStoryboard.bridgeConnectSegue {
            if let bridges = self.bridges {
                if let ipAddress = bridges[0]["internalipaddress"].string {
                    let viewController = segue.destinationViewController as BridgeConnectViewController
                    viewController.ipAddress = ipAddress
                }
            }
        }
    }
    
    func addDefaultBeacons() {
        for beacon in defaultBeacons {
            DataStore.addBeacon(beacon.name, uuid:beacon.uuid, store:DataStore.BeaconStore.configuredBeacons)
        }
    }
}
