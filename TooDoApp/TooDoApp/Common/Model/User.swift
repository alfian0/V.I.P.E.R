//
//  User.swift
//  TooDoApp
//
//  Created by Harshad on 25/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var username: String?
    var identifier: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        username <- map["username"]
        identifier <- map["_id"]
    }
}


struct SignUpResponse: Mappable {
    var user: User?
    var error: APIError?
    var token: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        user <- map["data.user"]
        error <- map["error"]
        token <- map["data.token"]
    }
}
