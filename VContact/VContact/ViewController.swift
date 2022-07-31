//
//  ViewController.swift
//  VContact
//
//  Created by Wally on 29.04.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    @IBAction private func enterButoon(_ sender: UIButton) {
        performAuth(email: loginTextField.text, password: passwordTextField.text, completion: { [weak self] isCompletion in
            DispatchQueue.main.async {
                if isCompletion {
                    self?.performSegue(withIdentifier: "finishAuth", sender: nil)
                } else {
                    self?.performSegue(withIdentifier: "finishAuth", sender: nil)
                    self?.loginTextField.text?.removeAll()
                    self?.passwordTextField.text?.removeAll()
                    return }
            }
        })
    }
   
    private func alertError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func performAuth(email: String? ,password: String?, completion: @escaping (Bool) -> Void) {
        guard let email = email,
              !email.isEmpty,
              let password = password,
              !password.isEmpty
              else {
            alertError(message: "Enter login and password")
            completion(false)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                self.alertError(message: error.localizedDescription)}
            completion(authResult != nil)
        }
    }
}

