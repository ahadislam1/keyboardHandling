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
    
    private var keyboardIsVisible = false
    private var originalCenterYConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        pulsateLogo()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterForKeyboardNotifications()
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        print("keyboardWillShow")
        
        // "UIKeyboardFrameBeginUserInfoKey"
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        print("Keyboard frame is \(keyboardFrame)")
        
        moveKeyboardUp(keyboardFrame.height)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        print("keyboardWillHide")
        resetUI()
    }
    
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        originalCenterYConstraint = pursuitLogoCenterYConstraint
        print("The current height to be moved is : \(height * 0.8)")
        pursuitLogoCenterYConstraint.constant -= height * 0.8
        keyboardIsVisible = true
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func resetUI() {
        keyboardIsVisible = false
        //-314 = 0 , + 314
        pursuitLogoCenterYConstraint.constant -= originalCenterYConstraint.constant
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func pulsateLogo() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [.repeat,.autoreverse], animations: {
            self.pursuitLogo.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }, completion: nil)
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
