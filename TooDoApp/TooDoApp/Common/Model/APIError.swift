//
//  APIError.swift
//  TooDoApp
//
//  Created by Harshad on 25/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import ObjectMapper

struct APIError: Mappable {
    var code: Int?
    var message: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}

extension APIError {
    var nsError: NSError {
        return NSError.errorWithCode(code, message: message)
    }
}

extension NSError {
    static func errorWithCode(code: Int?, message: String?) -> NSError {
        let codeToUse = code ?? -999
        let messageToUse = message ?? "Unknown error occurred"
        return NSError(domain: "com.gojek.todo", code: codeToUse, userInfo: [NSLocalizedDescriptionKey : messageToUse])
    }
}