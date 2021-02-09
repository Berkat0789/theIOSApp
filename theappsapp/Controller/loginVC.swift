//
//  loginVC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/9/21.
//

import UIKit
import Firebase

class loginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginPressed(_ sender: Any) {
        guard let email = emailTextField.text, let pass = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let err = error {
                //There was an error
                print("There has been an error loggin in \(err)")
            } else {
                print("Login Successfull")
                //There was no error
                self.performSegue(withIdentifier: K.segues.loginToApps, sender: self)
            }
        }
    }
    
}
