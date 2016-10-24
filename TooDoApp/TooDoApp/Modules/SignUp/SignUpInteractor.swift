//
//  SignUpInteractor.swift
//  GoProducts
//
//  Created by Alfiansyah.
//  Copyright © 2016 Go-jek. All rights reserved.
//

protocol ISignUpInteractor: class {
    weak var presenter: ISignUpPresenter? { get set }
    func signUp(email: String, password: String, confirmPassword: String)
}

class SignUpInteractor : ISignUpInteractor{
    weak var presenter: ISignUpPresenter?
    
    let service:ITodoService
    
    init(service:ITodoService){
        self.service = service
    }
    
    func signUp(email: String, password: String, confirmPassword: String) {
        service.signUpWithEmail(email, password: password, success: {[weak self] (response) in
            guard let user = response?.user else {
                self?.presenter?.failedToSignUp(response?.error?.nsError)
                return
            }
            self?.presenter?.didSignUp(user)
            
        }) {[weak self] (response, data, error) in
            self?.presenter?.failedToSignUp(error)
        }
    }
}
