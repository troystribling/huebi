//
//  FoundBeaconsViewController.swift
//  huebi
//
//  Created by Troy Stribling on 11/28/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit
import BlueCapKit

class FoundBeaconsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct MainStoryboard {
        static let foundBeaconCell = "FoundBeaconCell"
    }
    
    @IBOutlet var beaconsView : UITableView!

    var regions  = [BeaconRegion]()
    
    var beacons : [Beacon] {
        return []
    }

    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated:Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func prepareForSegue(segue:UIStoryboardSegue, sender:AnyObject?) {
    }
    
    func startMonitoring() {
        for (uuid, name) in DataStore.getBeacons(DataStore.BeaconStore.configuredBeacons) {
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
                    self.beaconsView.reloadData()
                    Notify.withMessage("Exited region '\(name)'. Stoped ranging beacons.")
                }
                beaconRegion.errorMonitoringRegion = {(error) in
                    BeaconManager.sharedInstance.stopRangingBeaconsInRegion(beaconRegion)
                    self.beaconsView.reloadData()
                    if let error = error {
                        self.presentViewController(UIAlertController.alertOnError(error), animated:true, completion:nil)
                    }
                }
                beaconRegion.rangedBeacons = {(beacons) in
                    for beacon in beacons {
                        Logger.debug("major:\(beacon.major), minor: \(beacon.minor), rssi: \(beacon.rssi)")
                    }
                    self.beaconsView.reloadData()
                }
            }
            self.regions.append(region)
        }
    }
    
    // Delegates methods
    func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return self.beacons.count
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.foundBeaconCell, forIndexPath: indexPath) as UITableViewCell
        return cell
    }

}
