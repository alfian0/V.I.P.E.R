//
//  AppRouter.swift
//  TooDoApp
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Swinject
import UIKit


class AppRouter :IAppRouter {
    private let rootVC:UIViewController!
    private let assembler:Assembler!
    private let modules : [String:(appRouter:IAppRouter)->IModule]
    private let navigationController:UINavigationController?
    
    private class func createAppRouter() -> IAppRouter {
        let vc = UIApplication.sharedApplication().delegate?.window??.rootViewController!
        
        
        let modules : [String:(appRouter:IAppRouter)->IModule] = [
            Module.ToDoList.routePath : {(appRouter:IAppRouter) in ToDoListModule(appRouter:appRouter)},
            Module.CreateTodo.routePath : {(appRouter: IAppRouter) in CreateTodoModule(appRouter: appRouter)},
            Module.EditTodo.routePath : {(appRouter: IAppRouter) in EditTodoModule(appRouter: appRouter)},
            Module.Profile.routePath : {(appRouter: IAppRouter) in ProfileModule(appRouter: appRouter)},
            Module.Login.routePath : {(appRouter: IAppRouter) in LoginModule(appRouter: appRouter)}
        ]
        
        let assembler = Assembler()
        assembler.applyAssemblies([CommonAssembly()])
        assembler.applyAssemblies([ToDoListAssembly(), CreateTodoAssembly(), EditTodoAssembly(),  ProfileAssembly(), LoginAssembly()])
        return AppRouter(rootVC: vc!, navigationController:getNavigationController(), assembler:assembler, modules: modules)
    }
    
    private class func getNavigationController() -> UINavigationController {
        let nc = UIApplication.sharedApplication().delegate?.window??.rootViewController as? UINavigationController ?? UINavigationController()
        return nc
    }
    
    class var sharedInstance : IAppRouter {
        struct Singleton {
            static let instance = AppRouter.createAppRouter()
        }
        
        return Singleton.instance
    }
    
    init(rootVC:UIViewController, navigationController:UINavigationController?, assembler:Assembler, modules:[String:(appRouter:IAppRouter)->IModule]){
        self.rootVC = rootVC
        self.navigationController = navigationController
        self.assembler = assembler
        self.modules = modules
    }
    
    var resolver: ResolverType {
        return assembler.resolver
    }
    
    func presentModule(module:Module,parameters:[String:Any]){
        if let moduleConstuctor = modules[module.routePath] {
            let module = moduleConstuctor(appRouter: self)
            module.presentView(parameters)
        }
    }
    
    
    func displayView(view:UIViewController?, animateDismiss:Bool, animateDisplay:Bool){
        displayView(view, animateDismiss:animateDismiss, animateDisplay:animateDisplay, completion:nil)
    }
    
    func displayView(view:UIViewController?, animateDismiss:Bool, animateDisplay:Bool, completion:(() -> Void)?){
        rootVC.dismissViewControllerAnimated(animateDismiss, completion: {() in
            if(view != nil){
                self.rootVC.presentViewController(view!, animated: animateDisplay, completion: completion)
            }
        })
    }
    
    func displayViewWithoutDismiss(view:UIViewController?,animateDisplay:Bool)
    {
        view?.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(view!, animated: true)
    }
    
    func stackToViewControllerType<T: UIViewController>(type: T.Type) -> [UIViewController]? {
        if let array = navigationController?.viewControllers {
            var controllers: [UIViewController] = [UIViewController]()
            for vc in array {
                if let _ = vc as? T {
                    return controllers
                }
                controllers.append(vc)
            }
        }
        return nil
    }
    
    func setViewControllersToStack(controllers:[UIViewController], animated: Bool) {
        for vc in controllers {
            if navigationController?.viewControllers.indexOf(vc) == nil {
                navigationController?.viewControllers.insert(vc, atIndex: (navigationController?.viewControllers.count)! - 1)
            }
        }
        navigationController?.setViewControllers(controllers, animated: animated)
    }
    
    func dismissViewFromNavigationController(animated:Bool,completion:()->())
    {
        navigationController?.popViewControllerAnimated(true)
        completion()
//        navigationController?.popViewControllerWithHandler(animated,completion:completion)
    }
    
    // Added for Just presenting and dismissing normaly
    func dismissPresentedViewController(animated:Bool, completion:(() -> Void)?) {
        navigationController?.presentedViewController?.dismissViewControllerAnimated(animated, completion: completion)
    }
    
    func presentViewController(view:UIViewController, animated:Bool, completion:(() -> Void)?) {
        view.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.rootVC.presentViewController(view, animated: animated, completion: completion)
    }
    
    func resetStackToView(view: UIViewController, animated: Bool) {
        navigationController?.setViewControllers([view], animated: true)
    }
}