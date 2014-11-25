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
        static let FoundBridgesSegue    = "FoundBridges"
        static let BridgesSegue         = "Bridges"
        static let BeaconsSegue         = "Beacons"
        static let NoBridgeFoundSegue   = "NoBridgeFound"
    }
    
    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        if DataStore.getSelectedBridge() == nil {
            HueClient.discoverBridge({(data) in
                if data.count == 0 {
                    self.presentViewController(UIAlertController.alertOnErrorWithMessage("No Hue bridge found. Please enter bridge IP address.", handler:{(action) in
                        self.performSegueWithIdentifier(MainStoryboard.NoBridgeFoundSegue, sender:self)
                    }), animated:true, completion:nil)
                } else if data.count == 1 {
                    self.presentViewController(UIAlertController.message("Hue Bridge Found", message:"You will have 30 second to authorize the application with the bridge by pressing the blue button after touching OK", handler:{(action) in
                        self.performSegueWithIdentifier(MainStoryboard.BridgeConnectSegue, sender:self)
                    }), animated:true, completion:nil)
                } else {
                    self.presentViewController(UIAlertController.message("Hue Bridges Found", message:"Multiple bridges were found. Please select one", handler:{(action) in
                        self.performSegueWithIdentifier(MainStoryboard.BridgesSegue, sender:self)
                    }), animated:true, completion:nil)
                }
            }, discoveyFailed:{(error) in
                self.presentViewController(UIAlertController.alertOnErrorWithMessage("Hue Bridge discovery failed. Please enter bridge IP address.", handler:{(action) in
                    self.performSegueWithIdentifier(MainStoryboard.NoBridgeFoundSegue, sender:self)
                }), animated:true, completion:nil)
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
