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
    
    class func discoverBridge(discoverySuccess:(data:JSON)->(), discoveyFailed:(error:NSError)->()) {
        Alamofire.request(.GET, "https://www.meethue.com/api/nupnp")
            .responseSwiftyJSON{(_, response, data, error) in
                if let error = error {
                    discoveyFailed(error:error)
                } else {
                    discoverySuccess(data:data)
                }
            }
    }
    
    class func createUser(ipaddress:String, username:String, devicetype:String, createSuccess:(data:JSON)->(), createFailed:(error:NSError)->()) {
        Alamofire.request(.POST,"http://\(ipaddress)/api", parameters:["devicetype":devicetype, "userbname":username])
            .responseSwiftyJSON(){(_,_, data, error) in
                if let error = error {
                    createFailed(error:error)
                } else {
                    createSuccess(data:data)
                }
            }
    }
}