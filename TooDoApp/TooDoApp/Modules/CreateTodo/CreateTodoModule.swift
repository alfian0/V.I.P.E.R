//
//  CreateTodoModule.swift
//  TooDoApp
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation

class CreateTodoModule : IModule{
    
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentView(parameters:[String:Any]){
        let wireframe = appRouter.resolver.resolve(ICreateTodoWireFrame.self, argument:appRouter)!
        wireframe.presentView(CreateTodoViewModel())
    }
    
}