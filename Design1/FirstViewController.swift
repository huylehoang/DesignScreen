//
//  FirstViewController.swift
//  Design1
//
//  Created by LeeX on 10/1/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    let names = ["The Codmother Fish and Chips", "Cockscomb", "Gary Danko", "Citizen's Band", "La Fusion"]
    let reviews = ["1367 Reviews", "230 Reviews", "4119 Reviews", "708 Reviews", "602 Reviews"]
    let addresses = ["2824 Jones St, North Beach/Telegraph Hill", "564 4th St, SoMa", "800 N Point St, Russian Hill", "1198 Folsom St, SoMa", "475 Pine St, San Francisco, CA 94104"]
    let kinds = ["British, Fish & Chips, Seafood", "Bars, American (New)", "American (New)", "American (New)", "Latin American"]
    let images = [UIImage(named: "CodmotherFish"), UIImage(named: "Cockscomb"), UIImage(named: "GaryDanko"), UIImage(named: "CitizenBand"), UIImage(named: "LaFusion")]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterContentForSearchText (searchText: String) {
        filteredArray = names.filter({ (name) -> Bool in
            return name.lowercased().contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""  {
            return self.filteredArray.count
        } else {
            return self.names.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.Name.text = filteredArray[indexPath.row]
        } else {
            cell.Name.text = self.names[indexPath.row]
        }
        cell.Reviews.text = self.reviews[indexPath.row]
        cell.Address.text = self.addresses[indexPath.row]
        cell.Kinds.text = self.kinds[indexPath.row]
        cell.restaurantImage.image = self.images[indexPath.row]
        return cell
    }
}
