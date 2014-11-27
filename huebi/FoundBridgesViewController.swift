//
//  FoundBridgesViewController.swift
//  huebi
//
//  Created by Troy Stribling on 11/25/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit

class FoundBridgesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct MainStoryboard {
        static let foundBridgeCell = "FoundBridgeCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.foundBridgeCell, forIndexPath: indexPath) as UITableViewCell
        return cell
    }

}
