//
//  Utils.swift
//  LoginTest
//
//  Created by Vittorio Grasso on 23/09/17.
//  Copyright © 2017 Vittorio Grasso. All rights reserved.
//

import Foundation
import UIKit

class Utils {    
    public func messageBox(title: String, message: String, view: UIViewController) {
        let msgBox = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        msgBox.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        view.present(msgBox, animated: true, completion: nil)
    }
}
