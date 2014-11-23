//
//  HueClient.swift
//  huebi
//
//  Created by Troy Stribling on 11/18/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import Foundation
import Alamofire
import BlueCapKit

class HueClient {
    
    class func discoverBridge(discoverySuccess:(data:AnyObject?)->(), discoveyFailed:(error:NSError)->()) {
        Alamofire.request(.GET, "https://www.meethue.com/api/nupnp").responseJSON{(_, _, data, error) in
            if let error = error {
                discoveyFailed(error:error)
            } else {
                discoverySuccess(data:data)
            }
        }
    }
    
}