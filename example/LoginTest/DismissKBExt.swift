//
//  DismissKBExt.swift
//  LoginTest
//
//  Created by Vittorio Grasso on 23/09/17.
//  Copyright © 2017 Vittorio Grasso. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKBWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKB))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKB() {
        view.endEditing(true)
    }
}
