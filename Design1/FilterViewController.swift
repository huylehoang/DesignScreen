//
//  FilterViewController.swift
//  Design1
//
//  Created by LeeX on 11/22/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

protocol FilterViewDelegate: class {
    func didReceiveSwitchData(switchSelected: [String])
    func didReceiveDistanceData(distanceSelected: String)
    func didReceiveSortByData(sortBySelected: String)
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchTableViewCellDelegate, CircleTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
//    weak var firstController:FirstViewController?
    
    var filterDelegate: FilterViewDelegate?
    
    var newDistanceString:String = ""
    
    var newSortByString:String = ""
    
    let sectionName = ["Offering","Distance","Sort By","Category","See All"]

    let offeringArray = ["Offering A Deal"]
    
    var distanceArray = ["Auto","0.3 miles","1 mile","5 miles","20 miles"]
    
    var distanceArrayUpdated:[String] = []
    
    var sortByArray = ["Best Match","Match 1","Match 2"]
    
    var sortByArrayUpdated:[String] = []
    
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
    
    var distanceSelected:String = ""
    
    var sortBySelected:String = ""
    
    var distanceDropDown = false
    var sortByDropDown = false
    var categoryDropDown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        if self.distanceArray.contains(distanceSelected) {
            distanceArrayUpdated = updateArray(array: distanceArray, arrayUpdated: distanceArrayUpdated, string: distanceSelected)
        } else {
            distanceArrayUpdated = distanceArray.map { $0 }
        }
        
        if self.sortByArray.contains(sortBySelected) {
            sortByArrayUpdated = updateArray(array: sortByArray, arrayUpdated: sortByArrayUpdated, string: sortBySelected)
        } else {
            sortByArrayUpdated = sortByArray.map { $0 }
        }

        navigationItem.title = "Filter"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(search))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.animateTableAfterFilter()
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
            return distanceArrayUpdated.count
        case 2:
            return sortByArrayUpdated.count
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
            if indexPath.row == 0 && distanceDropDown == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: "dropCell") as! DropTableViewCell
                cell.dropLabel?.text = self.distanceArrayUpdated[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "circleCell") as! CircleTableViewCell
                cell.circleDelegate = self
                cell.circleLabel?.text = self.distanceArray[indexPath.row]
                cell.type = .distance
                return cell
            }
        case sectionName[2]:
            if indexPath.row == 0 && sortByDropDown == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: "dropCell") as! DropTableViewCell
                cell.dropLabel?.text = self.sortByArrayUpdated[indexPath.row]
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "circleCell") as! CircleTableViewCell
                cell.circleDelegate = self
                cell.circleLabel?.text = self.sortByArray[indexPath.row]
                cell.type = .sortBy
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

        if indexPath.section == 1 {
            distanceDropDown = !distanceDropDown
            if self.distanceArray.contains(newDistanceString) {
                distanceArrayUpdated = updateArray(array: distanceArray, arrayUpdated: distanceArrayUpdated, string: newDistanceString)
                tableView.reloadSections(IndexSet(1...1), with: .automatic)
            }
            if indexPath.row == 0 {
                tableView.reloadSections(IndexSet(1...1), with: .automatic)
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        
        if indexPath.section == 2{
            sortByDropDown = !sortByDropDown
            if self.sortByArray.contains(newSortByString) {
                sortByArrayUpdated = updateArray(array: sortByArray, arrayUpdated: sortByArrayUpdated, string: newSortByString)
                tableView.reloadSections(IndexSet(2...2), with: .automatic)
            } else {
                tableView.reloadSections(IndexSet(2...2), with: .automatic)
                tableView.beginUpdates()
                tableView.endUpdates()
            }
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
        self.filterDelegate?.didReceiveSwitchData(switchSelected: switchCategorySelected)
        self.filterDelegate?.didReceiveDistanceData(distanceSelected: newDistanceString)
        self.filterDelegate?.didReceiveSortByData(sortBySelected: newSortByString)
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
    
    func didSelected(cell: CircleTableViewCell, string: String) {
        if cell.type == CircleCellType.distance {
            self.newDistanceString = string
        } else {
            self.newSortByString = string
        }
    }
    
    func updateArray (array: [String], arrayUpdated: [String], string: String) -> [String]{
        var arrayUpdated = array.map {$0}
        let index = arrayUpdated.index(of: string)
        arrayUpdated.remove(at: index!)
        arrayUpdated.insert(string, at: 0)
        return arrayUpdated
    }
}
