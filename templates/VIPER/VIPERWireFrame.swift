//
//  VIPERWireFrame.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//


protocol IVIPERWireFrame: class {

}


class VIPERWireFrame: IVIPERWireFrame {

    let appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

}