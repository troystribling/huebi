//
//  BridgesViewController.swift
//  huebi
//
//  Created by Troy Stribling on 11/23/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit

class BridgesViewController: UITableViewController {

    struct MainStoryboard {
        static let BridgeCell = "BridgeCell"
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

    override func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        return 1
    }

    override func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return 0
    }

    override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.BridgeCell, forIndexPath: indexPath) as UITableViewCell
        return cell
    }

}
