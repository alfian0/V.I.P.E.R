//
//  VIPERInteractor.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//

protocol IVIPERInteractor: class {
    weak var presenter: IVIPERPresenter? { get set }
}

class VIPERInteractor : IVIPERInteractor{
    weak var presenter: IVIPERPresenter?
}
