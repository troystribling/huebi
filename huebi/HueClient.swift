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
    
    func discoverBridge() {
        Alamofire.request(.GET, "www.meethue.com/api/nupnp").response{(request, response, data, error) in
            println(request)
            println(response)
            println(error)
            println(data)
        }
    }
    
}