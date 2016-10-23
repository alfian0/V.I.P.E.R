//
//  ToDoListModule.swift
//  TooDoApp
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation

class ToDoListModule : IModule{
    
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentView(parameters:[String:Any]){
        let wireframe = appRouter.resolver.resolve(IToDoListWireFrame.self, argument:appRouter)!
        wireframe.presentListView(ToDoListViewModel())
    }
    
}