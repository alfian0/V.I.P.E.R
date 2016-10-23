//
//  ToDoListInterceptorMock.swift
//  TooDoApp
//
//  Created by admin on 12/10/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import MockFive

class ToDoListInterceptorMock : Mock, IToDoListInterceptor {
    let mockFiveLock: String = lock()

    var _presenter: IToDoListPresenter?
    
    var presenter : IToDoListPresenter?{
        set { _presenter = newValue }
        get { return _presenter }
    }

    
    func getTodos(){
        stub(identifier: "get ToDos")
        _presenter?.gotTodos([TodoItem(identifier: "id1",description: "Item 1"),
                              TodoItem(identifier: "id2",description: "Item 2")])
    }
    
    func deleteTodoWithID(todoID: String){
        stub(identifier: "delete ToDo With Id", arguments: todoID)
        _presenter?.deletedTodoWithID(todoID)
    }
}