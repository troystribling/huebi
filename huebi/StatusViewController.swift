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
        static let bridgeConnectSegue   = "BridgeConnect"
        static let foundBridgesSegue    = "FoundBridges"
        static let bridgesSegue         = "Bridges"
        static let beaconsSegue         = "Beacons"
        static let noBridgeFoundSegue   = "NoBridgeFound"
    }
    
    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        if DataStore.getSelectedBridge() == nil {
            HueClient.discoverBridge({(data) in
                if data.count == 0 {
                    self.performSegueWithIdentifier(MainStoryboard.noBridgeFoundSegue, sender:self)
                } else if data.count == 1 {
                    self.performSegueWithIdentifier(MainStoryboard.bridgeConnectSegue, sender:self)
                } else {
                    self.performSegueWithIdentifier(MainStoryboard.bridgesSegue, sender:self)
                }
            }, discoveyFailed:{(error) in
                self.performSegueWithIdentifier(MainStoryboard.noBridgeFoundSegue, sender:self)
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
