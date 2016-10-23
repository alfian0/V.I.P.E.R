//
//  IModule.swift
//  TooDoApp
//
//  Created by admin on 23/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation


public protocol IModule {
    func presentView(parameters:[String : Any])
}