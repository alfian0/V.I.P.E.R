//
//  SignUpPresenter.swift
//  GoProducts
//
//  Created by Alfiansyah.
//  Copyright © 2016 Go-jek. All rights reserved.
//

import Foundation

protocol ISignUpPresenter: class {
    func doSignUp(email: String?, password: String?, confirmPassword: String?)
    func didSignUp(user: User)
    func failedToSignUp(error: NSError?)
}

class SignUpPresenter : ISignUpPresenter {

	weak private var view: ISignUpView!
	private let interactor: ISignUpInteractor
    private let wireframe: ISignUpWireFrame
    private let viewModel: SignUpViewModel

    init(view: ISignUpView, viewModel:SignUpViewModel, interactor: ISignUpInteractor, wireframe: ISignUpWireFrame) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.viewModel = viewModel
    }
    
    func doSignUp(email: String?, password: String?, confirmPassword: String?) {
        guard let enteredEmail = email where enteredEmail.characters.count > 0 else {
            view.showErrorMessage("Please enter a valid email")
            return
        }
        
        guard let enteredPassword = password where enteredPassword.characters.count > 0 else {
            view.showErrorMessage("Please enter a valid password")
            return
        }
        
        if enteredPassword != confirmPassword {
            view.showErrorMessage("Your password and confirm password did not match")
            return
        }
        
        view.showLoading()
        interactor.signUp(enteredEmail, password: enteredPassword)
    }
    
    func didSignUp(user: User) {
        wireframe.showListScreen()
    }
    
    func failedToSignUp(error: NSError?) {
        view.showErrorMessage(error?.localizedDescription ?? "Unable to Sign Up")
    }
}


