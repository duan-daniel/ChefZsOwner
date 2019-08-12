//
//  ResponsesDetailedTableViewController.swift
//  ChefZsOwner
//
//  Created by Daniel Duan on 8/12/19.
//  Copyright © 2019 Daniel Duan. All rights reserved.
//

import UIKit

class ResponsesDetailedTableViewController: UITableViewController {
    
    var dish: Dish!
    var schoolArray = ["CHS", "CMS", "HHS", "Hyde", "Lynbrook", "MVHS", "Miller"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = dish.name
        tableView.separatorStyle = .none
        tableView.rowHeight = 85
        
    }
    
    // MARK: - Section Data Source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return schoolArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "responsesDetailedHeaderCell") as! ResponsesDetailedHeaderTableViewCell
        
        var schoolText = ""
        var largeSizeText = ""
        var mediumSizeText = ""
        
        switch section {
        case 0:
            // CHS Section
            schoolText = "CHS"
            largeSizeText = ("\(dish.schools["CHSLarge"]!.count) Larges")
            mediumSizeText = ("\(dish.schools["CHSMedium"]!.count) Mediums")
        case 1:
            // CMS Section
            schoolText = "CMS"
            largeSizeText = ("\(dish.schools["CMSLarge"]!.count) Larges")
            mediumSizeText = ("\(dish.schools["CMSMedium"]!.count) Mediums")
        case 2:
            //  HHS Section
            schoolText = "HHS"
            largeSizeText = ("\(dish.schools["HHSLarge"]!.count) Larges")
            mediumSizeText = ("\(dish.schools["HHSMedium"]!.count) Mediums")
        case 3:
            // Hyde Section
            schoolText = "Hyde"
            largeSizeText = ("\(dish.schools["HydeLarge"]!.count) Larges")
            mediumSizeText = ("\(dish.schools["HydeMedium"]!.count) Mediums")
        case 4:
            // Lynbrook Section
            schoolText = "Lynbrook"
            largeSizeText = ("\(dish.schools["LynbrookLarge"]!.count) Larges")
            mediumSizeText = ("\(dish.schools["LynbrookMedium"]!.count) Mediums")
        case 5:
            // MVHS Section
            schoolText = "MVHS"
            largeSizeText = ("\(dish.schools["MVHSLarge"]!.count) Larges")
            mediumSizeText = ("\(dish.schools["MVHSMedium"]!.count) Mediums")
        default:
            // Miller Section
            schoolText = "Miller"
            largeSizeText = ("\(dish.schools["MillerLarge"]!.count) Larges")
            mediumSizeText = ("\(dish.schools["MillerMedium"]!.count) Mediums")
        }
        
        cell.schoolNameLabel.text = schoolText
        cell.largeSizeLabel.text = largeSizeText
        cell.mediumSizeLabel.text = mediumSizeText
        return cell

    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            // CHS Section
            return (dish.schools["CHSLarge"]!.count + dish.schools["CHSMedium"]!.count)
        case 1:
            // CMS Section
            return (dish.schools["CMSLarge"]!.count + dish.schools["CMSMedium"]!.count)
        case 2:
            // HHS Section
            return (dish.schools["HHSLarge"]!.count + dish.schools["HHSMedium"]!.count)
        case 3:
            // Hyde Section
            return (dish.schools["HydeLarge"]!.count + dish.schools["HydeMedium"]!.count)
        case 4:
            // Lynbrook Section
            return (dish.schools["LynbrookLarge"]!.count + dish.schools["LynbrookMedium"]!.count)
        case 5:
            // MVHS Section
            return (dish.schools["MVHSLarge"]!.count + dish.schools["MVHSMedium"]!.count)
        default:
            // Miller Section
            return (dish.schools["MillerLarge"]!.count + dish.schools["MillerMedium"]!.count)
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "responsesDetailedCell", for: indexPath) as! ResponsesDetailedTableViewCell
        
        var customersArray = [Profile]()
        
        let section = indexPath.section
        if section == 0 {
            // CHS Section
            for childName in dish.schools["CHSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Large"))
            }
            for childName in dish.schools["CHSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Medium"))
            }
        }
        else if section == 1 {
            // CMS Section
            for childName in dish.schools["CMSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Large"))
            }
            for childName in dish.schools["CMSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Medium"))
            }
        }
        else if section == 2 {
            // HHS Section
            for childName in dish.schools["HHSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Large"))
            }
            for childName in dish.schools["HHSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Medium"))
            }
        }
        
        else if section == 3 {
            // Hyde Section
            for childName in dish.schools["HydeLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Large"))
            }
            for childName in dish.schools["HydeMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Medium"))
            }
        }
        else if section == 4 {
            // Lynbrook Section
            for childName in dish.schools["LynbrookLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Large"))
            }
            for childName in dish.schools["LynbrookMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Medium"))
            }
        }
        else if section == 5 {
            // MVHS Section
            for childName in dish.schools["MVHSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Large"))
            }
            for childName in dish.schools["MVHSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Medium"))
            }
        }
        else {
            // Miller Section
            for childName in dish.schools["MillerLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Large"))
            }
            for childName in dish.schools["MillerMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "Medium"))
            }
        }
        
        cell.viewOfContent.layer.cornerRadius = 10
        cell.viewOfContent.layer.masksToBounds = true
        
        cell.childNameLabel.text = customersArray[indexPath.row].childName
        cell.sizeLabel.text = customersArray[indexPath.row].dishSize
      

        return cell
    }
 

}
