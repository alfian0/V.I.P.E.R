//
//  VIPERPresenter.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//

protocol IVIPERPresenter: class {
}

class VIPERPresenter : IVIPERPresenter {

	weak private var view: IVIPERView!
	private let interactor: IVIPERInteractor
    private let wireframe: IVIPERWireFrame
    private let viewModel: VIPERViewModel

    init(view: IVIPERView, viewModel:VIPERViewModel, interactor: IVIPERInteractor, wireframe: IVIPERWireFrame) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.viewModel = viewModel
    }
}


