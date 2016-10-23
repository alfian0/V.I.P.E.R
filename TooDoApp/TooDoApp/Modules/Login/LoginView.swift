//
//  LoginView.swift
//  GoProducts
//
//  Created by Venkatesh.
//  Copyright © 2016 Go-jek. All rights reserved.
//

import UIKit

protocol ILoginView : class {
    func showLoading()
    func hideLoading()
    func showErrorMessage(message: String)
}

class LoginView: UIViewController, ILoginView, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField?
    @IBOutlet weak var passwordField: UITextField?

	var presenter: ILoginPresenter!

    init(){
        super.init(nibName: "LoginView", bundle:nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


	override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(LoginView.touchDone))
        navigationItem.rightBarButtonItem = doneButton
    }

    func touchDone() {
        presenter.doLogin(emailField?.text, password: passwordField?.text)
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
