//
//  LocationPickerWireFrame.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import Swinject

protocol IProfileWireFrame {
    func presentView(viewModel:ProfileViewModel)
    func goBack()
    func showLoginModule()
    func showSignUpModule()
}


class ProfileWireFrame : IProfileWireFrame{
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentView(viewModel:ProfileViewModel){
        let view = appRouter.resolver.resolve(ProfileView.self, arguments:(appRouter, viewModel))!
        appRouter.resetStackToView(view, animated: true)
    }
    
    func goBack() {
        appRouter.dismissViewFromNavigationController(true, completion: {})
    }
    
    func showLoginModule() {
        appRouter.presentModule(Module.Login, parameters: [:])
    }
    
    func showSignUpModule() {
        appRouter.presentModule(Module.SignUp, parameters: [:])
    }
}