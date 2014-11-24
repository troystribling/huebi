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

    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        if DataStore.getBridge() == nil {
            HueClient.discoverBridge({(data) in
                Logger.debug("\(data)")
            }, discoveyFailed:{(error) in
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
    
}
