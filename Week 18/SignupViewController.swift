//
//  SignupViewController.swift
//  Covid-19_Project
//
//  Created by admin on 02/05/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signupBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let pass = passwordField.text {
            if email.count > 5 && pass.count > 5 {
                if repeatPasswordField.text == pass {
                    Authentication.signUp(email: email, pass: pass)
                } else {
                    let ac = UIAlertController(title: "Passwords not matching", message: "Your passwords need to be identical", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    present(ac, animated: true)
                }
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
