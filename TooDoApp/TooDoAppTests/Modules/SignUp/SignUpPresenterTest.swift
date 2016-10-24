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
    }
}