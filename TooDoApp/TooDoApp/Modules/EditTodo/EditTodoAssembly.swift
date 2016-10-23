//
//  EditTodoAssembly.swift
//  TooDoApp
//
//  Editd by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Swinject


class EditTodoAssembly: AssemblyType {
    
    func assemble(container: Container) {
        container.register(IEditTodoInterceptor.self) { r in
            let service = r.resolve(ITodoService.self)!
            return EditTodoInterceptor(service: service)
        }
        
        container.register(IEditTodoWireFrame.self) { (r, appRouter: IAppRouter) in
            EditTodoWireFrame(appRouter: appRouter)
        }
        
        container.register(IEditTodoPresenter.self) { (r, view: IEditTodoView, viewModel:EditTodoViewModel, appRouter:IAppRouter) in
            let interceptor = r.resolve(IEditTodoInterceptor.self)!
            let wireframe = r.resolve(IEditTodoWireFrame.self, argument: appRouter)!
            let presenter = EditTodoPresenter(view: view, viewModel: viewModel, wireframe: wireframe, interceptor: interceptor)
            interceptor.presenter = presenter
            return presenter
        }
        
        
        container.register(EditTodoView.self) {  (r, appRouter: IAppRouter, viewModel:EditTodoViewModel) in
            let view = EditTodoView()
            let presenter = r.resolve(IEditTodoPresenter.self, arguments: (view as IEditTodoView,viewModel:viewModel, appRouter))!
            view.presenter = presenter
            return view
        }
        
    }
    
}