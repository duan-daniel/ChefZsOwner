//
//  ViewController.swift
//  ChefZsOwner
//
//  Created by Daniel Duan on 7/18/19.
//  Copyright © 2019 Daniel Duan. All rights reserved.
//

import UIKit
import TextFieldEffects
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateUser()
        
        // Round button corners
        signInButton.layer.cornerRadius = 20
        createAccountButton.layer.cornerRadius = 20
        
        // Add done button to keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
        
        // Disable Sign In Button until all Text Fields are filled in
        configureTextFields()
        updateTextField()
    }
    
    // MARK: - See if user is previously signed in
    func authenticateUser() {
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if ((user) != nil) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToMenuFromSignIn", sender: self)
                }
            }
            else {
                print("no user is signed in")
            }
        }
    }
    
    // MARK: - Disable Button
    func configureTextFields() {
        // create an array of textfields
        let textFieldArray = [emailTextField, passwordTextField]
        
        // configure them...
        for textField in textFieldArray {
            // make sure you set the delegate to be self
            textField?.delegate = self
            // add a target to them
            textField?.addTarget(self, action: #selector(LoginViewController.updateTextField), for: .editingChanged)
        }
    }
    
    @objc func updateTextField() {
        // create an array of textFields
        let textFields = [emailTextField, passwordTextField]
        // create a bool to test if a textField is blank in the textFields array
        let oneOfTheTextFieldsIsBlank = textFields.contains(where: {($0?.text ?? "").isEmpty})
        if oneOfTheTextFieldsIsBlank {
            signInButton.isEnabled = false
            signInButton.alpha = 0.5
        } else {
            signInButton.isEnabled = true
            signInButton.alpha = 1.0
        }
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        // sign in user with Firebase
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            //            if let error = error, user == nil {
            //                let alert = UIAlertController(title: "Sign In Failed",
            //                                              message: error.localizedDescription,
            //                                              preferredStyle: .alert)
            //
            //                alert.addAction(UIAlertAction(title: "OK", style: .default))
            //
            //                self.present(alert, animated: true, completion: nil)
            //            }
            
            if error != nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error?.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
                //                print(error!.localizedDescription)
                //                print(error!._code)
                //                self.handleError(error!)      // use the handleError method
                //                return
            }
            //            else if user != nil {
            //                // successfully logged in—go to home screen
            //                self.performSegue(withIdentifier: "goToHomeFromSignIn", sender: self)
            //            }
        })
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToCreateAccountViewController", sender: self)
    }
    
}

