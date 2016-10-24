//
//  SignUpViewMock.swift
//  TooDoApp
//
//  Created by alfian on 24/10/2016.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import MockFive

class SignUpViewMock: ISignUpView, Mock {
    let mockFiveLock: String = lock()
    
    func showLoading() {
        stub(identifier: "show Loading")
    }
    
    func hideLoading() {
        stub(identifier: "hide Loading")
    }
    
    func showErrorMessage(message: String) {
        stub(identifier: "show Error Message", arguments: message)
    }
}