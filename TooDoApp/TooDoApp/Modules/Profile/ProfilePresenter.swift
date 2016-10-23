//
//  ToDoPresenter
//  GoJek
//
//  Editd by Venkatesh on 23/09/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol IProfilePresenter : class {
    func doInitialSetup()
    func loginPressed()
    func signUpPressed()
}

class ProfilePresenter : IProfilePresenter {
    weak var view:IProfileView!
    let wireframe:IProfileWireFrame
    var viewModel:ProfileViewModel
    let interceptor:IProfileInterceptor
    
    init(view:IProfileView,viewModel:ProfileViewModel, wireframe:IProfileWireFrame, interceptor:IProfileInterceptor){
        self.view = view
        self.wireframe = wireframe
        self.viewModel = viewModel
        self.interceptor = interceptor
    }
    
    func doInitialSetup() {
        view.hoookUpEvents()
    }
    
    func loginPressed() {
        wireframe.showLoginModule()
    }
    
    func signUpPressed() {
        wireframe.showSignUpModule()
    }
    
}