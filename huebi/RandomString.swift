//
//  RandomString.swift
//  huebi
//
//  Created by Troy Stribling on 11/27/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import Foundation

extension Int {
    
    static func random(min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
    
}

extension String {
    
    var length: Int {return countElements(self)}

    subscript (i: Int) -> String {
        return String(Array(self)[i])
    }
    
    static func random (var length len:Int = 0, charset:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        
        if len < 1 {
            len = Int.random(max: 16)
        }
        
        var result = String()
        let max = charset.length - 1
        
        for i in 1...len {
            result = result + charset[Int.random(min:0, max:max)]
        }
        
        return result
        
    }

}