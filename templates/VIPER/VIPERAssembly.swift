//
//  VIPERAssembly.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//

import Foundation
import Swinject

class VIPERAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(IVIPERInteractor.self) { _ in
            VIPERInteractor()
        }

        container.register(IVIPERWireFrame.self) { (r, appRouter: IAppRouter) in
            VIPERWireFrame(appRouter: appRouter)
        }

        container.register(IVIPERPresenter.self) { (r, view: IVIPERView, viewModel:VIPERViewModel, appRouter: IAppRouter) in
            let interactor = r.resolve(IVIPERInteractor.self)!
            let wireframe = r.resolve(IVIPERWireFrame.self, argument: appRouter)!
            let presenter = VIPERPresenter(view: view, viewModel:viewModel, interactor: interactor, wireframe: wireframe)
            interactor.presenter = presenter
            return presenter
        }

        container.register(VIPERView.self) {  (r, appRouter: IAppRouter, viewModel:VIPERViewModel) in
            let view = VIPERView()
            let presenter = r.resolve(IVIPERPresenter.self, arguments: (view as IVIPERView,viewModel:viewModel, appRouter))!
            view.presenter = presenter

            return view
        }

    }

}