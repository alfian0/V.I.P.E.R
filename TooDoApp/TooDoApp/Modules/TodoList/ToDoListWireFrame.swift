//
//  LocationPickerWireFrame.swift
//  GoJek
//
//  Created by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import Swinject

protocol IToDoListWireFrame {
    func presentListView(viewModel:ToDoListViewModel)
    func presentAddModule()
    func presentEditModule(todo: TodoItem)
}


class ToDoListWireFrame : IToDoListWireFrame{
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentListView(viewModel:ToDoListViewModel){
        let view = appRouter.resolver.resolve(ToDoListView.self, arguments:(appRouter, viewModel))!
        appRouter.resetStackToView(view, animated: true)
    }
    
    func presentAddModule() {
        appRouter.presentModule(Module.CreateTodo, parameters: [:])
    }
    
    func presentEditModule(todo: TodoItem) {
        appRouter.presentModule(Module.EditTodo, parameters: ["todoItem" : todo])
    }
        
}