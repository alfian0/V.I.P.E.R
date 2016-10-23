//
//  TodoService.swift
//  TooDoApp
//
//  Created by Harshad on 25/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Alamofire

protocol IAuthManager {
    func saveToken(token: String)
    var authHeaders: [String : String] {get}
    var canAuthorize: Bool {get}
}

class AuthManager: IAuthManager {
    static let sharedManager = AuthManager()
    private (set) var token: String = ""
    
    func saveToken(token: String) {
        self.token = token
    }
    
    var authHeaders: [String : String] {
        return ["Authorization" : "Bearer " + token]
    }
    
    var canAuthorize: Bool {
        return token.characters.count > 0
    }
}

typealias NetworkFailureHandler = (NSHTTPURLResponse?, AnyObject?, NSError?) -> Void

let BASE_URL = "http://localhost:4000"

protocol ITodoService {
    func getTodos(success: (GetTodosResponse?) -> Void, failure: NetworkFailureHandler)
    func createTodo(description: String, success: (CreateTodoResponse?) -> Void, failure: NetworkFailureHandler)
    func updateTodoWithID(todoID: String, description: String, success: (CreateTodoResponse?) -> Void, failure: NetworkFailureHandler)
    func deleteTodoWithID(todoID: String, success: (DeleteTodoResponse?) -> Void, failure: NetworkFailureHandler)
    func signUpWithEmail(email: String, password: String, success:(SignUpResponse?) -> Void, failure: NetworkFailureHandler)
    func loginWithEmail(email: String, password: String, success:(SignUpResponse?) -> Void, failure: NetworkFailureHandler)
}

class TodoService: ITodoService {
    private let authManager: IAuthManager
    
    init(authManager: IAuthManager) {
        self.authManager = authManager
    }
    
    func getTodos(success: (GetTodosResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/todos"
        Alamofire.request(.GET, url, headers: authManager.authHeaders).responseString { response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            success(GetTodosResponse(JSONString: jsonString))
        }
        
    }
    
    func createTodo(description: String, success: (CreateTodoResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/todos/create"
        Alamofire.request(.POST, url, parameters: ["description" : description], headers: authManager.authHeaders).responseString { response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            success(CreateTodoResponse(JSONString: jsonString))
        }
    }
    
    func updateTodoWithID(todoID: String, description: String, success: (CreateTodoResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/todos/" + todoID
        Alamofire.request(.PATCH, url, parameters: ["description" : description], headers: authManager.authHeaders).responseString { response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            success(CreateTodoResponse(JSONString: jsonString))
        }
    }
    
    func deleteTodoWithID(todoID: String, success: (DeleteTodoResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/todos/" + todoID
        Alamofire.request(.DELETE, url, headers: authManager.authHeaders).responseString { response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            success(DeleteTodoResponse(JSONString: jsonString))
        }
    }
    
    func signUpWithEmail(email: String, password: String, success: (SignUpResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/register"
        Alamofire.request(.POST, url, parameters: ["username" : email, "password" : password], headers: [:]).responseString {[weak self] response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            let signupResponse = SignUpResponse(JSONString: jsonString)
            if let token = signupResponse?.token {
                self?.authManager.saveToken(token)
                success(signupResponse)
            } else {
                failure(response.response, response.data, signupResponse?.error?.nsError)
            }
        }
    }
    
    func loginWithEmail(email: String, password: String, success: (SignUpResponse?) -> Void, failure: NetworkFailureHandler) {
        let url = BASE_URL + "/login"
        Alamofire.request(.POST, url, parameters: ["username" : email, "password" : password], headers: [:]).responseString {[weak self] response in
            guard let jsonString = response.result.value else {
                failure(response.response, response.data, response.result.error)
                return
            }
            let signupResponse = SignUpResponse(JSONString: jsonString)
            if let token = signupResponse?.token {
                self?.authManager.saveToken(token)
                success(signupResponse)
            } else {
                failure(response.response, response.data, signupResponse?.error?.nsError)
            }
        }
    }
}
