//
//  EditTodoModule.swift
//  TooDoApp
//
//  Editd by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation

class EditTodoModule : IModule{
    
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentView(parameters:[String:Any]){
        guard let todoItem = parameters["todoItem"] as? TodoItem else {
            fatalError("Attempting to present Edit Todo Module without a todo item")
        }
        let wireframe = appRouter.resolver.resolve(IEditTodoWireFrame.self, argument:appRouter)!
        wireframe.presentView(EditTodoViewModel(todoItem: todoItem))
    }
    
}