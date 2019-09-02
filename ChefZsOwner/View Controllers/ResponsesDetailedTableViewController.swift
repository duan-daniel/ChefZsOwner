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
    var schoolArray = ["CHS", "CMS", "HHS", "Hyde", "Lynbrook", "MVHS", "Miller", "Lawson", "KMS", "SHS"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 30
        tableView.separatorStyle = .none
        self.navigationItem.title = dish.name
        
    }
    
    // MARK: - Section Data Source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "responsesDetailedFooterCell") as! ResponsesDetailedFooterTableViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9703344703, green: 0.9704967141, blue: 0.9703131318, alpha: 1)
        return cell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return schoolArray.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "responsesDetailedHeaderCell") as! ResponsesDetailedHeaderTableViewCell
        
        var schoolText = ""
        var largeSizeText = ""
        var mediumSizeText = ""
        var smallSizeText = ""
        
        switch section {
        case 0:
            // CHS Section
            schoolText = "CHS"
            largeSizeText = ("\(dish.schools["CHSLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["CHSMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["CHSSmall"]!.count) S")
        case 1:
            // CMS Section
            schoolText = "CMS"
            largeSizeText = ("\(dish.schools["CMSLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["CMSMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["CMSSmall"]!.count) S")

        case 2:
            //  HHS Section
            schoolText = "HHS"
            largeSizeText = ("\(dish.schools["HHSLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["HHSMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["HHSSmall"]!.count) S")

        case 3:
            // Hyde Section
            schoolText = "Hyde"
            largeSizeText = ("\(dish.schools["HydeLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["HydeMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["HydeSmall"]!.count) S")

        case 4:
            // Lynbrook Section
            schoolText = "Lynbrook"
            largeSizeText = ("\(dish.schools["LynbrookLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["LynbrookMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["LynbrookSmall"]!.count) S")

        case 5:
            // MVHS Section
            schoolText = "MVHS"
            largeSizeText = ("\(dish.schools["MVHSLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["MVHSMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["MVHSSmall"]!.count) S")

        case 6:
            // Miller Section
            schoolText = "Miller"
            largeSizeText = ("\(dish.schools["MillerLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["MillerMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["MillerSmall"]!.count) S")

        case 7:
            // Lawson Section
            schoolText = "Lawson"
            largeSizeText = ("\(dish.schools["LawsonLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["LawsonMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["LawsonSmall"]!.count) S")
        case 8:
            // KMS Section
            schoolText = "KMS"
            largeSizeText = ("\(dish.schools["KMSLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["KMSMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["KMSSmall"]!.count) S")
        default:
            // SHS Section
            largeSizeText = ("\(dish.schools["SHSLarge"]!.count) L")
            mediumSizeText = ("\(dish.schools["SHSMedium"]!.count) M")
            smallSizeText = ("\(dish.schools["SHSSmall"]!.count) S")
        }
        
        cell.schoolNameLabel.text = schoolText
        cell.largeSizeLabel.text = largeSizeText
        cell.mediumSizeLabel.text = mediumSizeText
        cell.smallSizeLabel.text = smallSizeText
        return cell

    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            // CHS Section
            return (dish.schools["CHSLarge"]!.count + dish.schools["CHSMedium"]!.count + dish.schools["CHSSmall"]!.count)
        case 1:
            // CMS Section
            return (dish.schools["CMSLarge"]!.count + dish.schools["CMSMedium"]!.count + dish.schools["CMSSmall"]!.count)
        case 2:
            // HHS Section
            return (dish.schools["HHSLarge"]!.count + dish.schools["HHSMedium"]!.count + dish.schools["HHSSmall"]!.count)
        case 3:
            // Hyde Section
            return (dish.schools["HydeLarge"]!.count + dish.schools["HydeMedium"]!.count + dish.schools["HydeSmall"]!.count)
        case 4:
            // Lynbrook Section
            return (dish.schools["LynbrookLarge"]!.count + dish.schools["LynbrookMedium"]!.count + dish.schools["LynbrookSmall"]!.count)
        case 5:
            // MVHS Section
            return (dish.schools["MVHSLarge"]!.count + dish.schools["MVHSMedium"]!.count + dish.schools["MVHSSmall"]!.count)
        case 6:
            // Miller Section
            return (dish.schools["MillerLarge"]!.count + dish.schools["MillerMedium"]!.count + dish.schools["MillerSmall"]!.count)
        case 7:
            // Lawson Section
            return (dish.schools["LawsonLarge"]!.count + dish.schools["LawsonMedium"]!.count + dish.schools["LawsonSmall"]!.count)
        case 8:
            // KMS Section
            return (dish.schools["KMSLarge"]!.count + dish.schools["KMSMedium"]!.count + dish.schools["KMSSmall"]!.count)
        default:
            // SHS Section
            return (dish.schools["SHSLarge"]!.count + dish.schools["SHSMedium"]!.count + dish.schools["SHSSmall"]!.count)

        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "responsesDetailedCell", for: indexPath) as! ResponsesDetailedTableViewCell
        
        var customersArray = [Profile]()
        
        let section = indexPath.section
        if section == 0 {
            // CHS Section
            for childName in dish.schools["CHSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["CHSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["CHSSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        else if section == 1 {
            // CMS Section
            for childName in dish.schools["CMSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["CMSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["CMSSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        else if section == 2 {
            // HHS Section
            for childName in dish.schools["HHSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["HHSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["HHSSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        
        else if section == 3 {
            // Hyde Section
            for childName in dish.schools["HydeLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["HydeMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["HydeSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        else if section == 4 {
            // Lynbrook Section
            for childName in dish.schools["LynbrookLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["LynbrookMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["LynbrookSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        else if section == 5 {
            // MVHS Section
            for childName in dish.schools["MVHSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["MVHSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["MVHSSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        else if section == 6 {
            // Miller Section
            for childName in dish.schools["MillerLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["MillerMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["MillerSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        else if section == 7 {
            // Lawson Section
            for childName in dish.schools["LawsonLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["LawsonMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["LawsonSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        else if section == 8 {
            // KMS Section
            for childName in dish.schools["KMSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["KMSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["KMSSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        else {
            // SHS Section
            for childName in dish.schools["SHSLarge"]! {
                customersArray.append(Profile(childName: childName, dishSize: "L,"))
            }
            for childName in dish.schools["SHSMedium"]! {
                customersArray.append(Profile(childName: childName, dishSize: "M,"))
            }
            for childName in dish.schools["SHSSmall"]! {
                customersArray.append(Profile(childName: childName, dishSize: "S,"))
            }
        }
        
        var childName = ""
        let str = customersArray[indexPath.row].childName
        if let range = str.range(of: "|") {
            let substring = str[..<range.lowerBound] // or str[str.startIndex..<range.lowerBound]
            childName = String(substring)
        }
        else {
            print("String not present")
        }
        
        let index = childName.count + 1
        let specificIndex = str.count - index
        let paymentMethod = str.suffix(specificIndex)
        
        cell.childNameLabel.text = "\(indexPath.row + 1) " + childName
        cell.sizeLabel.text = customersArray[indexPath.row].dishSize
        cell.paymentMethodLabel.text = String(paymentMethod)
      

        return cell
    }
 

}
