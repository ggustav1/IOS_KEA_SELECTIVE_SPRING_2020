//
//  ViewController.swift
//  Covid-19_Project
//
//  Created by Thomas Vindelev on 01/05/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var authentication: Authentication?
        
    override func viewDidLoad() {
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        super.viewDidLoad()
        authentication = Authentication(parentVC: self)
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        if let email = usernameTextField.text, let pass = passwordTextField.text {
            if email.count > 5 && pass.count > 5 {
                Authentication.signIn(email: email, pass: pass)
            }
        }
    }
    
    @IBAction func touchBtnPressed(_ sender: UIButton) {
        Authentication.touchIDAuth(VC: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
