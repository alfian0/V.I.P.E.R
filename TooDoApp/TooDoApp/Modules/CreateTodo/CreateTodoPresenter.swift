//
//  ToDoPresenter
//  GoJek
//
//  Created by Venkatesh on 23/09/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol ICreateTodoPresenter : class {
    func doInitialSetup()
    func saveTodo(description: String?)
    func savedTodo(todo: TodoItem)
    func failedToSaveTodo(error: NSError?)
}

class CreateTodoPresenter : ICreateTodoPresenter {
    weak var view:ICreateTodoView!
    let wireframe:ICreateTodoWireFrame
    var viewModel:CreateTodoViewModel
    let interceptor:ICreateTodoInterceptor
    
    init(view:ICreateTodoView,viewModel:CreateTodoViewModel, wireframe:ICreateTodoWireFrame, interceptor:ICreateTodoInterceptor){
        self.view = view
        self.wireframe = wireframe
        self.viewModel = viewModel
        self.interceptor = interceptor
    }
    
    func doInitialSetup() {
        view.hoookUpEvents()
    }
    
    func saveTodo(description: String?) {
        guard let todoText = description?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) where todoText.characters.count > 0 else {
            view.showErrorMessage("Please enter the todo text")
            return
        }
        view.showLoading()
        interceptor.createTodoItem(todoText)
    }
    
    func savedTodo(todo: TodoItem) {
        view.hideLoading()
        wireframe.goBack()
    }
    
    func failedToSaveTodo(error: NSError?) {
        view.hideLoading()
        view.showErrorMessage(error?.localizedDescription ?? "There was an error saving the todo item")
    }

}