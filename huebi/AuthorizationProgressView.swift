//
//  AuthorizationProgressView.swift
//  BlueCap
//
//  Created by Troy Stribling on 7/20/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIkit
import BlueCapKit

class AuthorizationProgressView : UIView {
    
    let BACKGROUND_ALPHA        : CGFloat           = 0.9
    let DISPLAY_REMOVE_DURATION : NSTimeInterval    = 0.5
    
    var counterLabel        : UILabel!
    var backgroundView      : UIView!
    
    var displayed = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.counterLabel = UILabel(frame:CGRectMake(self.center.x, self.center.y, 50, 50))
        self.counterLabel.font = UIFont(name:"Menlo", size:35)
        self.counterLabel.center = self.center
        self.counterLabel.textColor = UIColor.redColor()
        self.backgroundView = UIView(frame:frame)
        self.backgroundView.backgroundColor = UIColor.whiteColor()
        self.backgroundView.alpha = BACKGROUND_ALPHA
        self.addSubview(self.backgroundView)
        self.addSubview(self.counterLabel)
    }
    
    override convenience init() {
        self.init(frame:UIScreen.mainScreen().bounds)
    }
    
    func show(count:Int, onComplete:Void->Void) {
        if let keyWindow =  UIApplication.sharedApplication().keyWindow {
            self.show(count, onComplete:onComplete, view:keyWindow)
        }
    }
    
    func show(count:Int, onComplete:Void->Void, view:UIView) {
        if !self.displayed {
            self.displayed = true
            self.counterLabel.text = "\(count)"
            view.addSubview(self)
            self.countdown(count, onComplete:onComplete)
        }
    }
    
    func remove() {
        if self.displayed {
            self.displayed = false
            UIView.animateWithDuration(DISPLAY_REMOVE_DURATION, animations:{
                    self.alpha = 0.0
                }, completion:{(finished) in
                    self.removeFromSuperview()
                    self.alpha = 1.0
                })
        }
    }
    
    func countdown(count:Int, onComplete:Void->Void) {
        if count > 0 {
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                self.counterLabel.text = "\(count-1)"
                self.countdown(count-1, onComplete:onComplete)
            }
        } else {
            onComplete()
        }
    }
}
