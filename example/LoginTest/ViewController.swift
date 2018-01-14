//
//  ViewController.swift
//  LoginTest
//
//  Created by Vittorio Grasso on 22/09/17.
//  Copyright © 2017 Vittorio Grasso. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTB: UITextField!
    @IBOutlet weak var passwordTB: UITextField!
    
    let utils = Utils()
    let authApi = AuthApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKBWhenTappedAround()
        usernameTB.delegate = self
        passwordTB.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginUser(_ sender: Any) {
        SwiftSpinner.show("Logging in...")
        DispatchQueue.global(qos: .userInitiated).async {
            self.authApi.username = self.usernameTB.text!
            self.authApi.password = self.passwordTB.text!
            self.authApi.loadUserInfo()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                let loggedInView = self.storyboard?.instantiateViewController(withIdentifier: "LoggedInView") as! LoggedInView
                dump(self.authApi.userInfo)
                loggedInView.jsonReturn = self.authApi.returnStringAsync!
                SwiftSpinner.hide()
                self.present(loggedInView, animated: true, completion: nil)
            }
        }
    }
}

class LoggedInView : UIViewController {
    
    @IBOutlet weak var jsonTB: UITextView!
    var jsonReturn = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonTB.text = jsonReturn
        hideKBWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logoutUser(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
