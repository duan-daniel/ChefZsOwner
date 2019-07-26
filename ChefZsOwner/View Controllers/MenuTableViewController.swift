//
//  MenuTableViewController.swift
//  ChefZsOwner
//
//  Created by Daniel Duan on 7/22/19.
//  Copyright © 2019 Daniel Duan. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MenuTableViewController: UITableViewController {
    
    var dishArray = [Dish]()
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Call some sort of load dishes on this line
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        
        db = Firestore.firestore()
        
    }
    
    // MARK: - Header Table View Data Source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sections = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
        cell.headerLabel.text = sections[section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell

        // Configure the cell...
        
        // Make pretty
        cell.viewOfContent.layer.cornerRadius = 10
        cell.viewOfContent.layer.masksToBounds = true

        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        guard let identifier = segue.identifier else { return }
        
        if identifier == "updateDish" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destination = segue.destination as! UpdateDishViewController
            
            let dishToUpdate = dishArray[indexPath.row]
            destination.dish = dishToUpdate
            
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
 

}
