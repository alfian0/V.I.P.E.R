//
//  SignUpWireFrameMock.swift
//  TooDoApp
//
//  Created by alfian on 24/10/2016.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import MockFive

class SignUpWireFrameMock: ISignUpWireFrame, Mock {
    let mockFiveLock: String = lock()
    
    func presentView(viewModel: SignUpViewModel) {
        stub(identifier: "present View")
    }
    
    func showListScreen() {
        stub(identifier: "show List Screen")
    }
}