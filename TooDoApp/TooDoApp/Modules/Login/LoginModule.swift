//
//  LoginInteractor.swift
//  GoProducts
//
//  Created by Venkatesh.
//  Copyright © 2016 Go-jek. All rights reserved.
//

import Foundation

class LoginModule: IModule {
    let appRouter: IAppRouter

    init(appRouter:IAppRouter) {
        self.appRouter = appRouter
    }

    func presentView(parameters:[String:Any]) {
        let wireframe = appRouter.resolver.resolve(ILoginWireFrame.self, argument:appRouter)!
        wireframe.presentView(LoginViewModel())
    }
}
