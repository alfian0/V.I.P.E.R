//
//  IAppRouter.swift
//  TooDoApp
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Swinject


public protocol IAppRouter : class {
    
    var resolver: ResolverType { get }
    
    func presentModule(module:Module,parameters:[String:Any])
    
    func displayView(view:UIViewController?, animateDismiss:Bool, animateDisplay:Bool)
    func displayView(view:UIViewController?, animateDismiss:Bool, animateDisplay:Bool, completion:(() -> Void)?)
    func displayViewWithoutDismiss(view:UIViewController?,animateDisplay:Bool)
    func dismissViewFromNavigationController(animated:Bool,completion: ()->())
    
    func presentViewController(view:UIViewController, animated:Bool, completion:(() -> Void)?)
    func dismissPresentedViewController(animated:Bool, completion:(() -> Void)?)
    
    func stackToViewControllerType<T: UIViewController>(type: T.Type) -> [UIViewController]?
    func setViewControllersToStack(controllers:[UIViewController], animated: Bool)
    
    func resetStackToView(view: UIViewController, animated: Bool)
}