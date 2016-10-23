//
//  Modules.swift
//  TooDoApp
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation

public enum Module{

    case ToDoList, CreateTodo, EditTodo, SignUp, Profile, Login
    
    public var routePath: String {
        switch self {
        case .ToDoList:
            return "/Modules/ToDoList"
            
        case .CreateTodo:
            return "/Modules/CreateTodo"
            
        case .EditTodo:
            return "/Modules/EditTodo"
            
        case .SignUp:
            return "/Modules/SignUp"
            
        case .Profile:
            return "/Modules/Profile"

        case .Login:
            return "/Modules/Login"

        }
    }

}