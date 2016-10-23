//
//  LocationPickerView.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import UIKit


protocol IProfileView : class{
    func hoookUpEvents()
}

class ProfileView : UIViewController, IProfileView {
    var presenter:IProfilePresenter!
    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet weak var signUpButton: UIButton?
    
    init(){
        super.init(nibName: "ProfileView", bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Profile"
        presenter.doInitialSetup()
    }
    
    // MARK: Actions
    
    func touchLogin() {
        presenter.loginPressed()
    }
    
    func touchSignUp() {
        presenter.signUpPressed()
    }
    
    // MARK: ITodoListView methods
    
    func hoookUpEvents() {
        loginButton?.addTarget(self, action: #selector(ProfileView.touchLogin), forControlEvents: .TouchUpInside)
        signUpButton?.addTarget(self, action: #selector(ProfileView.touchSignUp), forControlEvents: .TouchUpInside)
    }
}