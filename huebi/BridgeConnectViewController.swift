//
//  BridgeConnectViewController.swift
//  huebi
//
//  Created by Troy Stribling on 11/20/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit

class BridgeConnectViewController: UIViewController {

    @IBOutlet var bridgeConnectProgressView : UIProgressView!

    var ipAddress : String!

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

    func updateProgressBar() {        
    }
}
