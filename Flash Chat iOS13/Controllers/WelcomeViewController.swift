//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//


import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    //this CLTyping is a cocoapod to animate the typing of the label when the app opens
    @IBOutlet weak var titleLabel: CLTypingLabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.isNavigationBarHidden = false

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = K.appName
        
//        titleLabel.text = ""
//        let titleText = "⚡️FlashChat"
//        var charIndex = 0.0
//
//        for letter in titleText{
//            print(letter)
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false){
//                (timer) in
//                self.titleLabel.text?.append(letter)
//            }
//            charIndex += 1
//
//
//        }

       
    }
    

}
