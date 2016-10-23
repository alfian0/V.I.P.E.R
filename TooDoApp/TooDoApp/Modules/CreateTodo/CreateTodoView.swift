//
//  LocationPickerView.swift
//  GoJek
//
//  Created by admin on 02/08/16.
//  Copyright © 2016 GoJek. All rights reserved.
//

import Foundation
import UIKit


protocol ICreateTodoView : class{
    func showLoading()
    func hideLoading()
    func showErrorMessage(message: String)
    func hoookUpEvents()
}

class CreateTodoView : UIViewController, ICreateTodoView {
    var presenter:ICreateTodoPresenter!
    @IBOutlet weak var textField: UITextField?
    
    init(){
        super.init(nibName: "CreateTodoView", bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Add Item"
        presenter.doInitialSetup()
    }
    
    // MARK: Actions
    
    func touchSave() {
        presenter.saveTodo(textField?.text)
    }
    
    
    // MARK: ITodoListView methods
    
    func hoookUpEvents() {
        let saveButton = UIBarButtonItem.init(barButtonSystemItem: .Save, target: self, action: #selector(CreateTodoView.touchSave))
        navigationItem.rightBarButtonItem = saveButton
        
        textField?.addTarget(self, action: #selector(CreateTodoView.touchSave), forControlEvents: .EditingDidEndOnExit)
        textField?.becomeFirstResponder()
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