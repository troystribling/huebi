//
//  NoBridgeFoundViewController.swift
//  huebi
//
//  Created by Troy Stribling on 11/25/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit

class NoBridgeFoundViewController: UIViewController {

    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var ipTextField   : UITextField!
    
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
    
    // UITextFieldDelegate
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        return true
    }
    
}
