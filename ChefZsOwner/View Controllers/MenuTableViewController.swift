//
//  MenuTableViewController.swift
//  ChefZsOwner
//
//  Created by Daniel Duan on 7/22/19.
//  Copyright © 2019 Daniel Duan. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MenuTableViewController: UITableViewController {
    
    var dishArray: [Dish] = []
    var mondayDishArray = [Dish]()
    var tuesdayDishArray = [Dish]()
    var wednesdayDishArray = [Dish]()
    var thursdayDishArray = [Dish]()
    var fridayDishArray = [Dish]()
    
    // Firebase Reading Variables
    var documents: [DocumentSnapshot] = []
    var listener: ListenerRegistration!

    // MARK: - Read from Firestore
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }

    fileprivate func baseQuery() -> Query {
        return Firestore.firestore().collection("foods")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
        
        self.query = baseQuery()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listener =  query?.addSnapshotListener { (documents, error) in
            guard let snapshot = documents else {
                print("Error fetching documents results: \(error!)")
                return
            }
            // results is all of the documents retrieved from "foods" collection
            let results = snapshot.documents.map { (document) -> Dish in
                if let dish = Dish(dictionary: document.data()) {
                    return dish
                } else {
                    fatalError("Unable to initialize type \(Dish.self) with dictionary \(document.data())")
                }
            }
            
            // clears the array of dishes
            self.mondayDishArray.removeAll()
            self.tuesdayDishArray.removeAll()
            self.wednesdayDishArray.removeAll()
            self.thursdayDishArray.removeAll()
            self.fridayDishArray.removeAll()
            
            self.dishArray = results
            self.documents = snapshot.documents
            
            // insert the specific dishes to respective dow
            for dish in self.dishArray {
                switch dish.id {
                case "mondayDish0":
                    self.mondayDishArray.insert(dish, at: 0)
                case "mondayDish1":
                    self.mondayDishArray.insert(dish, at: 1)
                case "tuesdayDish0":
                    self.tuesdayDishArray.insert(dish, at: 0)
                case "tuesdayDish1":
                    self.tuesdayDishArray.insert(dish, at: 1)
                case "wednesdayDish0":
                    self.wednesdayDishArray.insert(dish, at: 0)
                case "wednesdayDish1":
                    self.wednesdayDishArray.insert(dish, at: 1)
                case "thursdayDish0":
                    self.thursdayDishArray.insert(dish, at: 0)
                case "thursdayDish1":
                    self.thursdayDishArray.insert(dish, at: 1)
                case "fridayDish0":
                    self.fridayDishArray.insert(dish, at: 0)
                case "fridayDish1":
                    self.fridayDishArray.insert(dish, at: 1)
                default:
                    print("\(dish.id) is fucking sth up")
                }
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.listener.remove()
    }
    
    // MARK: - Header Table View Data Source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
        if (dishArray.count != 0) {
            let mondayHeader = "Monday | \(mondayDishArray[0].date)"
            let tuesdayHeader = "Tuesday | \(tuesdayDishArray[0].date)"
            let wednesdayHeader = "Wednesday | \(wednesdayDishArray[0].date)"
            let thursdayHeader = "Thursday | \(thursdayDishArray[0].date)"
            let fridayHeader = "Friday | \(fridayDishArray[0].date)"
            let sections = [mondayHeader, tuesdayHeader, wednesdayHeader, thursdayHeader, fridayHeader]
            cell.headerLabel.text = sections[section]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return mondayDishArray.count
        case 1:
            return tuesdayDishArray.count
        case 2:
            return wednesdayDishArray.count
        case 3:
            return thursdayDishArray.count
        default:
            return fridayDishArray.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        // Make pretty
        cell.viewOfContent.layer.cornerRadius = 10
        cell.viewOfContent.layer.masksToBounds = true
        
        if dishArray.count != 0 {
            switch indexPath.section {
            case 0:
                let dish = mondayDishArray[indexPath.row]
                cell.dishLabel.text = dish.name
            case 1:
                let dish = tuesdayDishArray[indexPath.row]
                cell.dishLabel.text = dish.name
            case 2:
                let dish = wednesdayDishArray[indexPath.row]
                cell.dishLabel.text = dish.name
            case 3:
                let dish = thursdayDishArray[indexPath.row]
                cell.dishLabel.text = dish.name
            default:
                let dish = fridayDishArray[indexPath.row]
                cell.dishLabel.text = dish.name
            }
        }

        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        guard let identifier = segue.identifier else { return }
        
        if identifier == "updateDish" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destination = segue.destination as! UpdateDishViewController
            destination.sectionIndex = indexPath.section
            destination.rowIndex = indexPath.row
            
            switch indexPath.section {
            case 0:
                destination.dish = mondayDishArray[indexPath.row]
            case 1:
                destination.dish = tuesdayDishArray[indexPath.row]
            case 2:
                destination.dish = wednesdayDishArray[indexPath.row]
            case 3:
                destination.dish = thursdayDishArray[indexPath.row]
            case 4:
                destination.dish = fridayDishArray[indexPath.row]
            default:
                print("sth is fucking up")
            }
        }
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
            self.signOut()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        } catch let error {
            print("failed to sign out with error..", error)
        }
    }
    

}
