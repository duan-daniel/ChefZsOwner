//
//  UpdateDishViewController.swift
//  ChefZsOwner
//
//  Created by Daniel Duan on 7/25/19.
//  Copyright © 2019 Daniel Duan. All rights reserved.
//

import UIKit
import FirebaseFirestore
import TextFieldEffects

class UpdateDishViewController: UIViewController, UITextFieldDelegate {
    
    // variables passed in from MenuTableViewController
    var dish: Dish!
    var sectionIndex = 0
    var rowIndex = 0
    
    // Firestore reference
    var db: Firestore!
    
    // date formatter
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTextField: HoshiTextField!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishNameTextField: HoshiTextField!
    @IBOutlet weak var updateButton: UIButton!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        setUpViews()
        
    }
    
    func setUpViews() {
        
        // creates toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        //        dateTextField.inputAccessoryView = toolbar
        dishNameTextField.inputAccessoryView = toolbar
        
        // date picker
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        
        // disables buttons until text fields are filled in
//        configureTextFields()
//        updateTextFields()
        
        // sets navigation title
        switch sectionIndex {
        case 0:
            self.navigationItem.title = "Monday"
        case 1:
            self.navigationItem.title = "Tuesday"
        case 2:
            self.navigationItem.title = "Wednesday"
        case 3:
            self.navigationItem.title = "Thursday"
        case 4:
            self.navigationItem.title = "Friday"
        default:
            print("this should not be printing")
        }
        
        dateTextField.text = dish.date
        dishNameTextField.text = dish.name
        updateButton.layer.cornerRadius = 20
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
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
//        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        
        // assign values
        var documentName = ""
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

        let dishName = dishNameTextField.text!
        let date = dateTextField.text!
        var schools = [String: [String]]()
        schools = ["CMSSmall": [],
                   "CMSMedium": [],
                   "CMSLarge": [],
                   "MillerSmall": [],
                   "MillerMedium": [],
                   "MillerLarge": [],
                   "MVHSSmall": [],
                   "MVHSMedium": [],
                   "MVHSLarge": [],
                   "LynbrookSmall":[],
                   "LynbrookMedium": [],
                   "LynbrookLarge": [],
                   "CHSSmall":[],
                   "CHSMedium": [],
                   "CHSLarge": [],
                   "HydeSmall": [],
                   "HydeMedium": [],
                   "HydeLarge": [],
                   "HHSSmall": [],
                   "HHSMedium": [],
                   "HHSLarge": [],
                   "LawsonSmall": [],
                   "LawsonMedium": [],
                   "LawsonLarge": [],
                   "KMSSmall": [],
                   "KMSMedium": [],
                   "KMSLarge": [],
                   "SHSSmall": [],
                   "SHSMedium": [],
                   "SHSLarge": []
                    ]
        
        
        // write to firebase
        let newDish = Dish(name: dishName, date: date, id: documentName, totalCount: [], smallCount: [], mediumCount: [], largeCount: [], fruitCount: [], waterCount: [], schools: schools)
        
        db.collection("foods").document(documentName).setData(newDish.dictionary) {
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

}
