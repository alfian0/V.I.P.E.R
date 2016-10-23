//
//  SignUpView.swift
//  GoProducts
//
//  Created by Alfiansyah.
//  Copyright © 2016 Go-jek. All rights reserved.
//

import UIKit

protocol ISignUpView : class {
    func showLoading()
    func hideLoading()
    func showErrorMessage(message: String)
}

class SignUpView: UIViewController, ISignUpView {
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var confirmPasswordTextField: UITextField?

	var presenter: ISignUpPresenter!

    init(){
        super.init(nibName: "SignUpView", bundle:nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(SignUpView.touchDone))
        navigationItem.rightBarButtonItem = doneButton
    }

    func touchDone() {
        presenter.doSignUp(emailTextField?.text, password: passwordTextField?.text, confirmPassword: confirmPasswordTextField?.text)
    }
    
    func showLoading() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func hideLoading() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func showErrorMessage(message: String) {
        showErrorAlertWithMessage(message, title: "")
    }
}
