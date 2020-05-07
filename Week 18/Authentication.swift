//
//  Authentication.swift
//  Covid-19_Project
//
//  Created by admin on 01/05/2020.
//  Copyright © 2020 KEA. All rights reserved.
//

import Foundation
import FirebaseAuth
import LocalAuthentication
import SwiftKeychainWrapper

class Authentication {
    
    static var auth = Auth.auth()
    let parentVC:UIViewController
    
    init(parentVC: UIViewController) {
        self.parentVC = parentVC
        Authentication.auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil {
                print("Status: user is logged in: \(user.debugDescription)")
                parentVC.performSegue(withIdentifier: "mapSegue", sender: parentVC)
            } else {
                print("Status: user is logged out")
                parentVC.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    static func getUsername() -> String {
        return (auth.currentUser?.email)!
    }
    
    static func signUp(email: String, pass: String) {
        auth.createUser(withEmail: email, password: pass) { (result, error) in
            if error == nil {
                KeychainWrapper.standard.set(email, forKey: "userEmail")
                KeychainWrapper.standard.set(pass, forKey: "userPassword")
                print("successfully signed up to Firebase \(result.debugDescription)")
            } else {
                print("Failed to log in \(error.debugDescription)")
            }
        }
    }
    
    static func signIn(email: String, pass: String) {
        auth.signIn(withEmail: email, password: pass) { (result, error) in
            if error == nil {
                print("Successfully logged in")
            } else {
                print("Failed to log in")
            }
        }
    }
    
    static func signOut() {
        do {
            Repository.removeUserLocation(username: self.getUsername())
            try auth.signOut()
        } catch let error {
            print("Error signing out \(error.localizedDescription)")
        }
    }
    
    static func touchIDAuth(VC: UIViewController) {
        if KeychainWrapper.standard.hasValue(forKey: "userEmail") && KeychainWrapper.standard.hasValue(forKey: "userPassword") {
            
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Identify yourself!"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    success, authenticationError in

                    DispatchQueue.main.async {
                        if success {
                                signIn(email: KeychainWrapper.standard.string(forKey: "userEmail")!, pass: KeychainWrapper.standard.string(forKey: "userPassword")!)
                            }
                        }
                    }
            } else {
                let ac = UIAlertController(title: "Biometrics not available", message: "Your device is not configured for biometric ID.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                VC.present(ac, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "No user", message: "You have not set up a user for this app yet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            VC.present(alert, animated: true)
        }
    }
}
