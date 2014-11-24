//
//  StatusViewController.swift
//  huebi
//
//  Created by Troy Stribling on 11/23/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit
import Alamofire
import BlueCapKit

class StatusViewController: UIViewController {

    struct MainStoryboard {
        static let BridgeConnectSegue   = "BridgeConnect"
        static let AddBridgeSegue       = "AddBridge"
        static let BeaconsSegue         = "Beacons"
        static let AddBeaconSegue       = "AddBeacon"
    }
    
    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        if DataStore.getBridge() == nil {
            HueClient.discoverBridge({(data) in
            }, discoveyFailed:{(error) in
                self.performSegueWithIdentifier(MainStoryboard.AddBridgeSegue, sender:self)
            })
        }
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
}
