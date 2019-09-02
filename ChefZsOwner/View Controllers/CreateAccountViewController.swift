//
//  CreateAccountViewController.swift
//  ChefZsOwner
//
//  Created by Daniel Duan on 7/21/19.
//  Copyright © 2019 Daniel Duan. All rights reserved.
//

import UIKit
import FirebaseAuth
import TextFieldEffects

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round button corners
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
    
    // MARK: - Temporarily Disable Sign Up Button
    
    func configureTextFields() {
        // create an array of textfields
        let textFieldArray = [emailTextField, passwordTextField]
        
        // configure them...
        for textField in textFieldArray {
            // make sure you set the delegate to be self
            textField?.delegate = self
            // add a target to them
            textField?.addTarget(self, action: #selector(CreateAccountViewController.updateTextField), for: .editingChanged)
        }
    }
    
    @objc func updateTextField() {
        // create an array of textFields
        let textFields = [emailTextField, passwordTextField]
        // create a bool to test if a textField is blank in the textFields array
        let oneOfTheTextFieldsIsBlank = textFields.contains(where: {($0?.text ?? "").isEmpty})
        if oneOfTheTextFieldsIsBlank {
            createAccountButton.isEnabled = false
            createAccountButton.alpha = 0.5
        } else {
            createAccountButton.isEnabled = true
            createAccountButton.alpha = 1.0
        }
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    

    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        // register user with Firebase
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error?.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
                Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!)
                self.performSegue(withIdentifier: "goToMenuFromCreateAccount", sender: self)
            }
            
        }
    }
    

}
