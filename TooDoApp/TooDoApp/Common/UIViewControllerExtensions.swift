//
//  UIViewControllerExtensions.swift
//  TooDoApp
//
//  Created by Harshad on 25/09/16.
//  Copyright © 2016 com.ios. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorAlertWithMessage(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}