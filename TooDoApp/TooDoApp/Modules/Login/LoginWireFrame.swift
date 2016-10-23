//
//  LoginWireFrame.swift
//  GoProducts
//
//  Created by Venkatesh.
//  Copyright © 2016 Go-jek. All rights reserved.
//


protocol ILoginWireFrame: class {
    func presentView(viewModel:LoginViewModel)
    func showListScreen()
}


class LoginWireFrame: ILoginWireFrame {

    let appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }
    
    func presentView(viewModel:LoginViewModel){
        let view = appRouter.resolver.resolve(LoginView.self, arguments:(appRouter, viewModel))!
        appRouter.displayViewWithoutDismiss(view, animateDisplay: false)
    }
    
    func showListScreen() {
        appRouter.presentModule(Module.ToDoList, parameters: [:])
    }

}