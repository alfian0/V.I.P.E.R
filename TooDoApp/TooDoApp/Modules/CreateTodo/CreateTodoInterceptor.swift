//
//  LocationPickerInterceptor.swift
//  GoJek
//
//  Created by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol ICreateTodoInterceptor  : class {
    var presenter : ICreateTodoPresenter? {get set}
    func createTodoItem(description: String)
}


class CreateTodoInterceptor : ICreateTodoInterceptor {
    weak var _presenter: ICreateTodoPresenter?
    var service: ITodoService
    
    var presenter : ICreateTodoPresenter? {
        set { _presenter = newValue }
        get { return _presenter}
    }
    
    init(service: ITodoService) {
        self.service = service
    }
    
    func createTodoItem(description: String) {
        service.createTodo(description, success: {[weak self] (response) in
            guard let todo = response?.todo else {
                self?.presenter?.failedToSaveTodo(response?.error?.nsError)
                return
            }
            self?.presenter?.savedTodo(todo)
            
            }) {[weak self] (response, data, error) in
                self?.presenter?.failedToSaveTodo(error)
        }
    }
}
