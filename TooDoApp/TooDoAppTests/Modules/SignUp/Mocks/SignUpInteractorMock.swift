//
//  SignUpInteractorMock.swift
//  TooDoApp
//
//  Created by alfian on 24/10/2016.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import MockFive

class SignUpIteractorMock: ISignUpInteractor, Mock {
    let mockFiveLock: String = lock()
    
    var _presenter: ISignUpPresenter?
    
    var presenter : ISignUpPresenter?{
        set { _presenter = newValue }
        get { return _presenter }
    }
    
    func signUp(email: String, password: String, confirmPassword: String) {
        stub(identifier: "sign Up", arguments: [email, password, confirmPassword])
        _presenter?.doSignUp(email, password: password, confirmPassword: confirmPassword)
    }
}