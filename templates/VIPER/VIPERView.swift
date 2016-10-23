//
//  VIPERView.swift
//  PRODUCT
//
//  Created by AUTHOR.
//  Copyright © YEAR COMPANY. All rights reserved.
//

import UIKit

protocol IVIPERView : class {

}

class VIPERView: UIViewController, IVIPERView {

	var presenter: IVIPERPresenter!

    init(){
        super.init(nibName: "VIPERView", bundle:nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


	override func viewDidLoad() {
        super.viewDidLoad()
    }

}
