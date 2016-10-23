//
//  LoginAssembly.swift
//  GoProducts
//
//  Created by Venkatesh.
//  Copyright © 2016 Go-jek. All rights reserved.
//

import Foundation
import Swinject

class LoginAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(ILoginInteractor.self) { r in
            let service = r.resolve(ITodoService.self)!
            return LoginInteractor(service:service)
        }

        container.register(ILoginWireFrame.self) { (r, appRouter: IAppRouter) in
            LoginWireFrame(appRouter: appRouter)
        }

        container.register(ILoginPresenter.self) { (r, view: ILoginView, viewModel:LoginViewModel, appRouter: IAppRouter) in
            let interactor = r.resolve(ILoginInteractor.self)!
            let wireframe = r.resolve(ILoginWireFrame.self, argument: appRouter)!
            let presenter = LoginPresenter(view: view, viewModel:viewModel, interactor: interactor, wireframe: wireframe)
            interactor.presenter = presenter
            return presenter
        }

        container.register(LoginView.self) {  (r,appRouter: IAppRouter, viewModel:LoginViewModel) in
            let view = LoginView()
            let presenter = r.resolve(ILoginPresenter.self, arguments: (view as ILoginView,viewModel:viewModel, appRouter))!
            view.presenter = presenter

            return view
        }

    }

}