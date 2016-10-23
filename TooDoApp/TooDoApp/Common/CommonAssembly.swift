//
//  CommonAssembly.swift
//  TooDoApp
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Swinject


public class CommonAssembly: AssemblyType {
    
    
    public init(){
        
    }
    
    public func assemble(container: Container) {
        container.register(ITodoService.self) { r in
            return TodoService(authManager: AuthManager.sharedManager)
        }
    }
    
}