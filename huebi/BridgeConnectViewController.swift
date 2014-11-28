//
//  BridgeConnectViewController.swift
//  huebi
//
//  Created by Troy Stribling on 11/20/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit
import BlueCapKit

class BridgeConnectViewController: UIViewController {

    @IBOutlet var authorizeButton   : UIButton!

    var ipAddress       : String!

    var username        = String.random(length:16)
    var deviceType      = "hubie@\(UIDevice.currentDevice().name)"
    var timerExpired    = false
    
    var progressView  = AuthorizationProgressView()

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
    
    @IBAction func authorize(sender:AnyObject?) {
        self.timerExpired = false
        Logger.debug("BridgeConnectViewController#createUser: \(self.ipAddress), \(self.username), \(self.deviceType)")
        self.progressView.show(30){
            self.timerExpired = true
        }
        self.waitForButtonPress()
    }

    func waitForButtonPress() {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        dispatch_after(popTime, dispatch_get_main_queue()) {
            HueClient.createUser(self.ipAddress, username:self.username, devicetype:self.deviceType,
                createSuccess:{(data) in
                    Logger.debug("BridgeConnectViewController#waitForButtonPress: \(data)")
                    if let status = data[0]["success"]["username"].string {
                        Logger.debug("BridgeConnectViewController#waitForButtonPress: Application authorization successful")
                        self.progressView.remove()
                        DataStore.setSelectedBridge(self.ipAddress)
                        DataStore.setUsername(self.username)
                    } else {
                        Logger.debug("BridgeConnectViewController#waitForButtonPress: Application authorization failed")
                        if self.timerExpired {
                            self.presentViewController(UIAlertController.message("Authorization failed", message:"Touch 'Authorize' again to retry.", handler:{(action) in
                                self.progressView.remove()
                            }), animated:true, completion:nil)
                        } else {
                            self.waitForButtonPress()
                        }
                    }
                },
                createFailed:{(error) in
                    self.presentViewController(UIAlertController.alertOnError(error, handler:{(action) in
                        self.progressView.remove()
                    }), animated:true, completion:nil)
                }
            )
        }
    }
}
