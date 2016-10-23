//
//  CreateTodoAssembly.swift
//  TooDoApp
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Swinject


class CreateTodoAssembly: AssemblyType {
    
    func assemble(container: Container) {
        container.register(ICreateTodoInterceptor.self) { r in
            let service = r.resolve(ITodoService.self)!
            return CreateTodoInterceptor(service: service)
        }
        
        container.register(ICreateTodoWireFrame.self) { (r, appRouter: IAppRouter) in
            CreateTodoWireFrame(appRouter: appRouter)
        }
        
        container.register(ICreateTodoPresenter.self) { (r, view: ICreateTodoView, viewModel:CreateTodoViewModel, appRouter:IAppRouter) in
            let interceptor = r.resolve(ICreateTodoInterceptor.self)!
            let wireframe = r.resolve(ICreateTodoWireFrame.self, argument: appRouter)!
            let presenter = CreateTodoPresenter(view: view, viewModel: viewModel, wireframe: wireframe, interceptor: interceptor)
            interceptor.presenter = presenter
            return presenter
        }
        
        
        container.register(CreateTodoView.self) {  (r, appRouter: IAppRouter, viewModel:CreateTodoViewModel) in
            let view = CreateTodoView()
            let presenter = r.resolve(ICreateTodoPresenter.self, arguments: (view as ICreateTodoView,viewModel:viewModel, appRouter))!
            view.presenter = presenter
            return view
        }
        
    }
    
}