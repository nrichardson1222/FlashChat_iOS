//
//  RegisterViewController.swift
//  Flash Chat iOS13
//


import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //they are optional strings so we need to use optional binding so we have if let statement
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              // ...
                if let e = error {
                    print(e.localizedDescription)
                }else{
                    //navigate to chat view controller since register was a success
                    //because we have closure we need the self keyword
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
        
       
    }
    
}
