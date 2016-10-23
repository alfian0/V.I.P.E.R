//
//  LocationPickerInterceptor.swift
//  GoJek
//
//  Editd by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation

protocol IProfileInterceptor  : class {
    var presenter : IProfilePresenter? {get set}
}

class ProfileInterceptor : IProfileInterceptor {
    weak var _presenter: IProfilePresenter?
    var service: ITodoService
    
    var presenter : IProfilePresenter? {
        set { _presenter = newValue }
        get { return _presenter}
    }
    
    init(service: ITodoService) {
        self.service = service
    }
}
