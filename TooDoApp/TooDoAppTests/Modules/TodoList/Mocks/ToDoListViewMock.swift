//
//  ToDoListViewMock.swift
//  TooDoApp
//
//  Created by admin on 12/10/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import MockFive

class ToDoListViewMock : Mock, IToDoListView {
    let mockFiveLock: String = lock()
    
    func showLoading(){
        stub(identifier: "show loading")
    }
    
    func hideLoading(){
        stub(identifier: "hide loading")
    }
    
    func redisplayTodos(){
        stub(identifier: "redisplay todos")
    }
    
    func showErrorMessage(message: String){
        stub(identifier: "show error message", arguments: message)
    }
    
    func hoookUpEvents(){
        stub(identifier: "hookup Events")
    }

}
