//
//  ViewController.swift
//  keyboardHandling
//
//  Created by Ahad Islam on 2/3/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pursuitLogo: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pursuitLogoCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForKeyboardNotifications() {
        
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        print("keyboardWillShow")
        print(notification.userInfo)
        
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        
    }


}

