//
//  UpdateDishViewController.swift
//  ChefZsOwner
//
//  Created by Daniel Duan on 7/25/19.
//  Copyright © 2019 Daniel Duan. All rights reserved.
//

import UIKit
import FirebaseFirestore

class UpdateDishViewController: UIViewController, UITextFieldDelegate {
    
    var dish: Dish!
    var sectionIndex = 0
    var rowIndex = 0
    var documentName = ""
    var dishName = ""
    var date = ""
    
    var db: Firestore!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishNameTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        // sets the document name
        switch sectionIndex {
        case 0:
            documentName = "mondayDish\(rowIndex)"
        case 1:
            documentName = "tuesdayDish\(rowIndex)"
        case 2:
            documentName = "wednesdayDish\(rowIndex)"
        case 3:
            documentName = "thursdayDish\(rowIndex)"
        case 4:
            documentName = "fridayDish\(rowIndex)"
        default:
            print("this should not be printing")
        }
        
        // creates date picker and toolbar
        createDatePicker()
        
        // Disable Sign In Button until all Text Fields are filled in
        configureTextFields()
        updateTextFields()

    }
    
    func createDatePicker() {
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
        
        // Add done button to keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
        dishNameTextField.inputAccessoryView = toolbar
    }
    
    func configureTextFields() {
        // create an array of textfields
        let textFieldArray = [dateTextField, dishNameTextField]
        
        // configure them...
        for textField in textFieldArray {
            // make sure you set the delegate to be self
            textField?.delegate = self
            // add a target to them
            textField?.addTarget(self, action: #selector(UpdateDishViewController.updateTextFields), for: .editingChanged)
        }
    }
    
    @objc func updateTextFields() {
        // create an array of textFields
        let textFields = [dateTextField, dishNameTextField]
        // create a bool to test if a textField is blank in the textFields array
        let oneOfTheTextFieldsIsBlank = textFields.contains(where: {($0?.text ?? "").isEmpty})
        if oneOfTheTextFieldsIsBlank {
            updateButton.isEnabled = false
            updateButton.alpha = 0.5
        } else {
            updateButton.isEnabled = true
            updateButton.alpha = 1.0
        }
    }
    
    @objc func doneClicked() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        
        
        
        dishName = dishNameTextField.text!
        date = dateTextField.text!
        
        // write to firebase
        
        let newDish = Dish(name: dishName, date: date, totalCount: [], mediumCount: [], largeCount: [], schools: [:])
        
        db.collection("dishes").document(documentName).setData(newDish.dictionary) {
            error in
            
            if let error = error {
                print("error adding document: \(error)")
            } else {
                print("document added!")
            }
        }
        
        // pop the view controller
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
