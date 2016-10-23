//
//  SignUpWireFrame.swift
//  GoProducts
//
//  Created by Alfiansyah.
//  Copyright © 2016 Go-jek. All rights reserved.
//


protocol ISignUpWireFrame: class {
    func presentView(viewModel:SignUpViewModel)
    func showListScreen()
}


class SignUpWireFrame: ISignUpWireFrame {
    let appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

    func presentView(viewModel: SignUpViewModel) {
        let view = appRouter.resolver.resolve(SignUpView.self, arguments:(appRouter, viewModel))!
        appRouter.displayViewWithoutDismiss(view, animateDisplay: false)
    }
    
    func showListScreen() {
        appRouter.presentModule(Module.ToDoList, parameters: [:])
    }
}