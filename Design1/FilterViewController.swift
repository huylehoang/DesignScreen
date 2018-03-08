//
//  FilterViewController.swift
//  Design1
//
//  Created by LeeX on 11/22/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

protocol FilterViewDelegate: class {
    func didReceiveData(switchSelected: [String])
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
//    weak var firstController:FirstViewController?
    
    var switchDelegate: FilterViewDelegate?
    
    let sectionName = ["Offering","Distance","Sort By","Category","See All"]

    let offeringArray = ["Offering A Deal"]
    
    let distanceArray = ["Auto","0.3 miles","1 mile","5 miles","20 mile"]
    
    let sortByArray = ["Best Match","Match 1","Match 2"]
    
    var categoryArray:[SwitchState] = [SwitchState(category: "American(New)", theSwitchState: false),
                                      SwitchState(category: "Thai", theSwitchState: false),
                                      SwitchState(category: "Bars", theSwitchState: false),
                                      SwitchState(category: "Noodles", theSwitchState: false),
                                      SwitchState(category: "Desserts", theSwitchState: false),
                                      SwitchState(category: "Vegan", theSwitchState: false),
                                      SwitchState(category: "Laotian", theSwitchState: false),
                                      SwitchState(category: "Comfort Food", theSwitchState: false),
                                      SwitchState(category: "Gluten-Free", theSwitchState: false),
                                      SwitchState(category: "Asian Fusion", theSwitchState: false),
                                      SwitchState(category: "Lounges", theSwitchState: false),
                                      SwitchState(category: "Vegetarian", theSwitchState: false),
                                      SwitchState(category: "Soup", theSwitchState: false),
                                      SwitchState(category: "Seafood", theSwitchState: false)]
    
    let seeAllArray = ["See All"]
    
    var switchCategorySelected:[String] = []
    
    var distanceDropDown = false
    var sortByDropDown = false
    var categoryDropDown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        navigationItem.title = "Filter"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(search))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animateTable()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionName[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 4{
            return 0
        }
        return 47.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionName.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return offeringArray.count
        case 1:
            return distanceArray.count
        case 2:
            return sortByArray.count
        case 3:
            return categoryArray.count
        default:
            return seeAllArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sectionName[indexPath.section]
        switch section {
        case sectionName[0]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchTableViewCell
            cell.switchLabel?.text = self.offeringArray[indexPath.row]
            return cell
        case sectionName[1]:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "dropCell") as! DropTableViewCell
                cell.dropLabel?.text = self.distanceArray[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "circleCell") as! CircleTableViewCell
                cell.circleLabel?.text = self.distanceArray[indexPath.row]
                return cell
            }
        case sectionName[2]:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "dropCell") as! DropTableViewCell
                cell.dropLabel?.text = self.sortByArray[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "circleCell") as! CircleTableViewCell
                cell.circleLabel?.text = self.sortByArray[indexPath.row]
                return cell
            }
        case sectionName[3]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchTableViewCell
            cell.delegate = self
            cell.switchLabel?.text = self.categoryArray[indexPath.row].category
                for j in switchCategorySelected {
                    if j == self.categoryArray[indexPath.row].category {
                        cell.toggle.isOn = true
                        return cell
                    } else {
                        cell.toggle.isOn = false
                    }
                }
            return cell
        case sectionName[4]:
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell") as! ButtonTableViewCell
            cell.buttonLabel?.text = self.seeAllArray[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0 && indexPath.section == 1{
            distanceDropDown = !distanceDropDown
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        if indexPath.row == 0 && indexPath.section == 2{
            sortByDropDown = !sortByDropDown
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        if indexPath.row == 0 && indexPath.section == 4{
            categoryDropDown = !categoryDropDown
            tableView.beginUpdates()
            tableView.endUpdates()
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            if distanceDropDown {
                return 47
            } else {
                return indexPath.row == 0 ? 47 : 0
            }
        case 2:
            if sortByDropDown {
                return 47
            } else {
                return indexPath.row == 0 ? 47 : 0
            }
        case 3:
            if categoryDropDown {
                return 47
            } else {
                return (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) ? 47 : 0
            }
        default:
            return 47
        }
    }
    
    @objc func search() {
        back()
        self.switchDelegate?.didReceiveData(switchSelected: switchCategorySelected)
    }
    
    @objc func back() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func mySwitchTapped(cell: SwitchTableViewCell, switchLabel: String) {
        if self.switchCategorySelected.contains(switchLabel) {
            let index = self.switchCategorySelected.index(of: switchLabel)
            self.switchCategorySelected.remove(at: index!)
        } else {
            self.switchCategorySelected.append(switchLabel)
        }
    }
    
    func animateTable() {
        self.tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableViewWidth = tableView.bounds.size.width
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: tableViewWidth, y: 0)
//            cell.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 0.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
