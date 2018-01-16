//
//  FilterViewController.swift
//  Design1
//
//  Created by LeeX on 11/22/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {



    @IBOutlet weak var tableView: UITableView!
    let sectionName = ["Offering",
                       "Distance",
                       "Distance Dropdown",
                       "Sort By",
                       "Sort By Dropdown",
                       "Category",
                       "Category Dropdown",
                       "See All"]

    let arrayOption = [["Offering A Deal"],
                       ["Auto"],
                       ["0.3 miles","1 mile","5 miles","20 mile"],
                       ["Best Match"],
                       ["Match 1","Match 2"],
                       ["Afgan","African","American(New)"],
                       ["American(Traditional)","Chinese","Italian","Vietnamese"],
                       ["See All"]]
    
    var distanceDropDown = false
    var sortByDropDown = false
    var categoryDropDown = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionName[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        }
        if (section == 2) {
            return 0
        }
        if (section == 4) {
            return 0
        }
        if (section == 6) {
            return 0
        }
        if (section == 7) {
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
        return self.arrayOption[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sectionName[indexPath.section]
        if section == sectionName[0] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchTableViewCell
            cell.switchLabel?.text = self.arrayOption[indexPath.section][indexPath.row]
            return cell
        }
        if section == sectionName[1] {
                let cell = tableView.dequeueReusableCell(withIdentifier: "dropCell") as! DropTableViewCell
                cell.dropLabel?.text = self.arrayOption[indexPath.section][indexPath.row]
                return cell
        }
        if section == sectionName[2] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "circleCell") as! CircleTableViewCell
            cell.circleLabel?.text = self.arrayOption[indexPath.section][indexPath.row]
            return cell
        }
        if section == sectionName[3] {
                let cell = tableView.dequeueReusableCell(withIdentifier: "dropCell") as! DropTableViewCell
                cell.dropLabel?.text = self.arrayOption[indexPath.section][indexPath.row]
                return cell
        }
        if section == sectionName[4] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "circleCell") as! CircleTableViewCell
            cell.circleLabel?.text = self.arrayOption[indexPath.section][indexPath.row]
            return cell
        }
        if section == sectionName[5] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchTableViewCell
            cell.switchLabel?.text = self.arrayOption[indexPath.section][indexPath.row]
            return cell
        }
        if section == sectionName[6] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchTableViewCell
            cell.switchLabel?.text = self.arrayOption[indexPath.section][indexPath.row]
            return cell
        }
        if section == sectionName[7] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell") as! ButtonTableViewCell
            cell.buttonLabel?.text = self.arrayOption[indexPath.section][indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0 && indexPath.section == 1{
            distanceDropDown = !distanceDropDown
            tableView.reloadData()
        }
        if indexPath.row == 0 && indexPath.section == 3{
            sortByDropDown = !sortByDropDown
            tableView.reloadData()
        }
        if indexPath.row == 0 && indexPath.section == 7{
            categoryDropDown = !categoryDropDown
            tableView.reloadData()
        }

        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if case indexPath.section = 2{
            if distanceDropDown == false {
                return 0.0
            }
            return 47
        }
        if case indexPath.section = 4 {
            if sortByDropDown == false {
                return 0.0
            }
            return 47
        }
        if case indexPath.section = 6 {
            if categoryDropDown == false {
                return 0.0
            }
            return 47
        }
        return 47
    }
    
}
