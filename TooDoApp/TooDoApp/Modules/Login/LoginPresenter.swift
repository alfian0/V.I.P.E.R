//
//  LoginPresenter.swift
//  GoProducts
//
//  Created by Venkatesh.
//  Copyright © 2016 Go-jek. All rights reserved.
//

import Foundation

protocol ILoginPresenter: class {
    func doLogin(email: String?, password: String?)
    func didLogin(user: User)
    func failedToLogin(error: NSError?)
}

class LoginPresenter : ILoginPresenter {

	weak private var view: ILoginView!
	private let interactor: ILoginInteractor
    private let wireframe: ILoginWireFrame
    private let viewModel: LoginViewModel

    init(view: ILoginView, viewModel:LoginViewModel, interactor: ILoginInteractor, wireframe: ILoginWireFrame) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.viewModel = viewModel
    }
    
    func doLogin(email: String?, password: String?) {
        guard let enteredEmail = email where enteredEmail.characters.count > 0 else {
            view.showErrorMessage("Please enter a valid email")
            return
        }
        
        guard let enteredPassword = password where enteredPassword.characters.count > 0 else {
            view.showErrorMessage("Please enter a valid password")
            return
        }
        
        view.showLoading()
        interactor.login(enteredEmail, password: enteredPassword)
    }
    
    func didLogin(user: User) {
        wireframe.showListScreen()
        
    }
    
    func failedToLogin(error: NSError?) {
        view.showErrorMessage(error?.localizedDescription ?? "Unable to login")
    }
}


