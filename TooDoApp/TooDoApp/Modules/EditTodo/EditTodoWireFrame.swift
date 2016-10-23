//
//  LocationPickerWireFrame.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import Swinject

protocol IEditTodoWireFrame {
    func presentView(viewModel:EditTodoViewModel)
    func goBack()
}


class EditTodoWireFrame : IEditTodoWireFrame{
    var appRouter:IAppRouter
    
    init(appRouter:IAppRouter){
        self.appRouter = appRouter
    }
    
    func presentView(viewModel:EditTodoViewModel){
        let view = appRouter.resolver.resolve(EditTodoView.self, arguments:(appRouter, viewModel))!
        appRouter.displayViewWithoutDismiss(view, animateDisplay: false)
    }
    
    func goBack() {
        appRouter.dismissViewFromNavigationController(true, completion: {})
    }
}