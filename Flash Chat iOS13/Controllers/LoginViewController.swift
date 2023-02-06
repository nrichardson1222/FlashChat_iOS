//
//  LoginViewController.swift
//  Flash Chat iOS13
//


import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            //this is the method to sign into the account that was previously registered
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              
              
                if let e = error {
                    print(e)
                }else{
                    //navigate to chat view controller since login was a success
                    self!.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
            
        }
        
    }
    
}
