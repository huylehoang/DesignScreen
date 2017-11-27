//
//  FilterViewController.swift
//  Design1
//
//  Created by LeeX on 11/22/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var offeringDeal: UILabel!
    @IBOutlet weak var TableView: UITableView!
    let sectionName = ["Category"]

    let arrayOption = [["Afgan","African","American(New)"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        TableView.delegate = self
        offeringDeal.text = "Offering A Deal"
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionName[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionName.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOption[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropBoxCell") as! DropBoxTableViewCell
        
        cell.myLabel.text = arrayOption[indexPath.section][indexPath.row] as? String
        
        return cell
        
    }
}
