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
    var ipAddress                   : String!

    var username        = String.random(length:16)
    var deviceType      = UIDevice.currentDevice().name
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
        self.progressView.show(30){
            self.timerExpired = true
        }
        self.createUser()
    }

    func createUser() {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        dispatch_after(popTime, dispatch_get_main_queue()) {
            HueClient.createUser(self.ipAddress, username:self.username, devicetype:self.deviceType,
                createSuccess:{(data) in
                    self.progressView.remove()
                    Logger.debug("\(data)")
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
