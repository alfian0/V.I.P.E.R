//
//  ProfileModule.swift
//  TooDoApp
//
//  Editd by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation

class ProfileModule : IModule{
    
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentView(parameters:[String:Any]){
        let wireframe = appRouter.resolver.resolve(IProfileWireFrame.self, argument:appRouter)!
        wireframe.presentView(ProfileViewModel())
    }
    
}