//
//  LocationPickerWireFrame.swift
//  GoJek
//
//  Created by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import Swinject

protocol ICreateTodoWireFrame {
    func presentView(viewModel:CreateTodoViewModel)
    func goBack()
}


class CreateTodoWireFrame : ICreateTodoWireFrame{
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentView(viewModel:CreateTodoViewModel){
        let view = appRouter.resolver.resolve(CreateTodoView.self, arguments:(appRouter, viewModel))!
        appRouter.displayViewWithoutDismiss(view, animateDisplay: false)
    }
    
    func goBack() {
        appRouter.dismissViewFromNavigationController(true, completion: {})
    }
}