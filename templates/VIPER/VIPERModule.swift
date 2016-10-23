//
//  VIPERInteractor.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//

import Foundation

class VIPERModule: IModule {
    let appRouter: IAppRouter

    init(appRouter:IAppRouter) {
        self.appRouter = appRouter
    }

    func presentView(parameters:[String:Any]) {
        //let wireframe = appRouter.resolver.resolve(IVIPERWireFrame.self, argument:appRouter)!
        //wireframe.present(VIPERViewModel())
    }
}
