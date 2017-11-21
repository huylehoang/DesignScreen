//
//  FilterViewController.swift
//  Design1
//
//  Created by LeeX on 11/22/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var DropBoxTableView: UITableView!
    @IBAction func DropBox(_ sender: Any) {
        DropBoxTableView.isHidden = !DropBoxTableView.isHidden
    }
    
    let arrayOption = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6"]
    override func viewDidLoad() {
        super.viewDidLoad()
        DropBoxTableView.dataSource = self
        DropBoxTableView.delegate = self
        
        DropBoxTableView.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropBoxCell") as! DropBoxTableViewCell
        
        cell.myLabel.text = arrayOption[indexPath.row] as? String
        
        return cell
        
    }
}
