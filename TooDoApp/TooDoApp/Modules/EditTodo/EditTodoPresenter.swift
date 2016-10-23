//
//  ToDoPresenter
//  GoJek
//
//  Editd by Venkatesh on 23/09/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol IEditTodoPresenter : class {
    func doInitialSetup()
    func saveTodo(description: String?)
    func savedTodo(todo: TodoItem)
    func failedToSaveTodo(error: NSError?)
}

class EditTodoPresenter : IEditTodoPresenter {
    weak var view:IEditTodoView!
    let wireframe:IEditTodoWireFrame
    var viewModel:EditTodoViewModel
    let interceptor:IEditTodoInterceptor
    
    init(view:IEditTodoView,viewModel:EditTodoViewModel, wireframe:IEditTodoWireFrame, interceptor:IEditTodoInterceptor){
        self.view = view
        self.wireframe = wireframe
        self.viewModel = viewModel
        self.interceptor = interceptor
    }
    
    func doInitialSetup() {
        view.hoookUpEvents()
        view.displayTodoText(viewModel.todoItem.description)
    }
    
    func saveTodo(description: String?) {
        guard let todoText = description?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) where todoText.characters.count > 0 else {
            view.showErrorMessage("Please enter the todo text")
            return
        }
        
        guard let itemID = viewModel.todoItem.identifier else {
            view.showErrorMessage("This item cannot be saved due to an internal error")
            return
        }
        
        
        view.showLoading()
        interceptor.updateDescriptionOfTodoItemWithID(itemID, description: todoText)
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