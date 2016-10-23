//
//  TodoItem.swift
//  TooDoApp
//
//  Created by Harshad on 25/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import ObjectMapper

struct TodoItem: Mappable {
    var description: String?
    var identifier: String?
    
    init?(_ map: Map) {
    }
    
    init(identifier: String?, description:String?){
        self.identifier = identifier
        self.description = description
    }

    
    mutating func mapping(map: Map) {
        description <- map["description"]
        identifier <- map["_id"]
    }
}

struct GetTodosResponse: Mappable {
    var todos: [TodoItem]?
    var error: APIError?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        todos <- map["data"]
        error <- map["error"]
    }
}

struct CreateTodoResponse: Mappable {
    var todo: TodoItem?
    var error: APIError?
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        todo <- map["data"]
        error <- map["error"]
    }
}

struct DeleteTodoResponse: Mappable {
    var message: String?
    var error: APIError?
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        message <- map["data.message"]
        error <- map["error"]
    }
}
