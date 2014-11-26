//
//  NoBridgeFoundViewController.swift
//  huebi
//
//  Created by Troy Stribling on 11/25/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit

class NoBridgeFoundViewController: UIViewController, UITextFieldDelegate {

    struct MainStoryBoard {
        static let noBridgeBridgeConnectSegue = "NoBridgeBridgeConnect"
    }
    
    @IBOutlet var nameTextField         : UITextField!
    @IBOutlet var ipAddressTextField    : UITextField!
    
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
        if segue.identifier == MainStoryBoard.noBridgeBridgeConnectSegue {
            if let ipAddress = self.ipAddressTextField.text {
                let viewController = segue.destinationViewController as BridgeConnectViewController
                viewController.ipAddress = self.ipAddressTextField.text
            }
        }
    }
    
    // UITextFieldDelegate
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        let name = self.nameTextField.text
        let ipAddress = self.ipAddressTextField.text
        if name != nil && ipAddress != nil {
            if !name.isEmpty && !ipAddress.isEmpty {
                DataStore.addBridge(name, ipAddress:ipAddress)
                self.performSegueWithIdentifier(MainStoryBoard.noBridgeBridgeConnectSegue, sender:self)
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}
