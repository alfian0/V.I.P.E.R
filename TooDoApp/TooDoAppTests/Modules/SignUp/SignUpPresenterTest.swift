//
//  SignUpPresenterTest.swift
//  TooDoApp
//
//  Created by alfian on 24/10/2016.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TooDoApp

class SignUpPresenterTest: QuickSpec {
    override func spec() {
        var viewModel:SignUpViewModel!
        let viewMock = SignUpViewMock()
        let wireFrameMock = SignUpWireFrameMock()
        let interceptorMock = SignUpIteractorMock()
        var presenter: SignUpPresenter!
        
        beforeEach{
            viewModel = SignUpViewModel()
            viewMock.resetMock()
            wireFrameMock.resetMock()
            interceptorMock.resetMock()
            presenter = SignUpPresenter(view: viewMock, viewModel: viewModel, interactor: interceptorMock, wireframe: wireFrameMock)
            interceptorMock.presenter = presenter
        }
        
        describe("Sign Up Test") {
            it("Invalid Sign Up : Invalid Email Address", closure: {
                presenter.doSignUp("", password: "", confirmPassword: "")
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("showErrorMessage(Please enter a valid email)"))
            })
            
            it("Invalid Sign Up : Invalid Password", closure: { 
                presenter.doSignUp("alfiansyah@go-jek.com", password: "", confirmPassword: "")
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("showErrorMessage(Please enter a valid password)"))
            })
            
            it("Invalid Sign Up : Confirm password did not match", closure: {
                presenter.doSignUp("alfiansyah@go-jek.com", password: "password", confirmPassword: "")
                expect(viewMock.invocations.count) == 1
                expect(viewMock.invocations).to(contain("showErrorMessage(Your password and confirm password did not match)"))
            })
            
//            it("Invalid Sign Up : This email address is already in use", closure: {
//                presenter.doSignUp("alfiansyah@go-jek.com", password: "password", confirmPassword: "password")
//                expect(viewMock.invocations.count) == 1
//                expect(viewMock.invocations).to(contain("showErrorMessage(This email address is already in use)"))
//            })
        }
    }
}