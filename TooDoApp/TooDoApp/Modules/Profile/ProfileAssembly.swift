//
//  ProfileAssembly.swift
//  TooDoApp
//
//  Editd by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Swinject


class ProfileAssembly: AssemblyType {
    
    func assemble(container: Container) {
        container.register(IProfileInterceptor.self) { r in
            let service = r.resolve(ITodoService.self)!
            return ProfileInterceptor(service: service)
        }
        
        container.register(IProfileWireFrame.self) { (r, appRouter: IAppRouter) in
            ProfileWireFrame(appRouter: appRouter)
        }
        
        container.register(IProfilePresenter.self) { (r, view: IProfileView, viewModel:ProfileViewModel, appRouter:IAppRouter) in
            let interceptor = r.resolve(IProfileInterceptor.self)!
            let wireframe = r.resolve(IProfileWireFrame.self, argument: appRouter)!
            let presenter = ProfilePresenter(view: view, viewModel: viewModel, wireframe: wireframe, interceptor: interceptor)
            interceptor.presenter = presenter
            return presenter
        }
        
        
        container.register(ProfileView.self) {  (r, appRouter: IAppRouter, viewModel:ProfileViewModel) in
            let view = ProfileView()
            let presenter = r.resolve(IProfilePresenter.self, arguments: (view as IProfileView,viewModel:viewModel, appRouter))!
            view.presenter = presenter
            return view
        }
        
    }
    
}