//
//  LoginInteractor.swift
//  GoProducts
//
//  Created by Venkatesh.
//  Copyright © 2016 Go-jek. All rights reserved.
//

protocol ILoginInteractor: class {
    weak var presenter: ILoginPresenter? { get set }
    func login(email: String, password: String)
}

class LoginInteractor : ILoginInteractor{
    weak var presenter: ILoginPresenter?
    let service:ITodoService
    
    init(service:ITodoService){
        self.service = service
    }
    
    func login(email: String, password: String) {
        service.loginWithEmail(email, password: password, success: {[weak self] (response) in
            guard let user = response?.user else {
                self?.presenter?.failedToLogin(response?.error?.nsError)
                return
            }
            self?.presenter?.didLogin(user)
            
            }) {[weak self] (response, data, error) in
                self?.presenter?.failedToLogin(error)
        }
    }
}
