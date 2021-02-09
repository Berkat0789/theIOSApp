//
//  registerVC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/9/21.
//

import UIKit
import Firebase

class registerVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        guard let email = email.text, let pass = password.text else {return}
        Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
            if let err = error {
                //There was an error
                print("error registering user \(err)")
            } else {
                print("User Registered")
                //There was no error
                self.performSegue(withIdentifier: K.segues.registerToApps, sender: self)
            }
        }
    }
    
    
    

}
