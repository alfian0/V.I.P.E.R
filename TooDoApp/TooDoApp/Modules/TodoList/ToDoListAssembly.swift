//
//  ToDoListAssembly.swift
//  TooDoApp
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Swinject


class ToDoListAssembly: AssemblyType {
    
    func assemble(container: Container) {
        container.register(IToDoListInterceptor.self) { r in
            let service = r.resolve(ITodoService.self)!
            return ToDoListInterceptor(service: service)
        }
        
        container.register(IToDoListWireFrame.self) { (r, appRouter: IAppRouter) in
            ToDoListWireFrame(appRouter: appRouter)
        }
        
        container.register(IToDoListPresenter.self) { (r, view: IToDoListView, viewModel:ToDoListViewModel, appRouter:IAppRouter) in
            let interceptor = r.resolve(IToDoListInterceptor.self)!
            let wireframe = r.resolve(IToDoListWireFrame.self, argument: appRouter)!
            let presenter = ToDoListPresenter(view: view, viewModel: viewModel, wireframe: wireframe, interceptor: interceptor)
            interceptor.presenter = presenter
            return presenter
        }
        
        
        container.register(ToDoListView.self) {  (r, appRouter: IAppRouter, viewModel:ToDoListViewModel) in
            let view = ToDoListView()
            let presenter = r.resolve(IToDoListPresenter.self, arguments: (view as IToDoListView,viewModel:viewModel, appRouter))!
            view.presenter = presenter
            return view
        }
        
    }
    
}