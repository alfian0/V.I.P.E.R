//
//  ToDoListWireframeMock.swift
//  TooDoApp
//
//  Created by admin on 12/10/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import MockFive

class ToDoListWireFrameMock : Mock, IToDoListWireFrame {
    let mockFiveLock: String = lock()
    
    func presentListView(viewModel:ToDoListViewModel){
        stub(identifier: "present List View")
    }
    
    func presentAddModule(){
        stub(identifier: "present Add Module")
    }
    
    func presentEditModule(todo: TodoItem){
        stub(identifier: "present Edit Module", arguments: todo.identifier)
    }
    
}
