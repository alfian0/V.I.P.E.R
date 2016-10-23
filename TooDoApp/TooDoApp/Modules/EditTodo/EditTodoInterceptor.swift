//
//  LocationPickerInterceptor.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol IEditTodoInterceptor  : class {
    var presenter : IEditTodoPresenter? {get set}
    func updateDescriptionOfTodoItemWithID(itemID: String, description: String)
}


class EditTodoInterceptor : IEditTodoInterceptor {
    weak var _presenter: IEditTodoPresenter?
    var service: ITodoService
    
    var presenter : IEditTodoPresenter? {
        set { _presenter = newValue }
        get { return _presenter}
    }
    
    init(service: ITodoService) {
        self.service = service
    }
    
    func updateDescriptionOfTodoItemWithID(itemID: String, description: String) {
        service.updateTodoWithID(itemID, description: description, success: {[weak self] (response) in
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
