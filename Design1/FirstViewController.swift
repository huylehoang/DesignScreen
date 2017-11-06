//
//  FirstViewController.swift
//  Design1
//
//  Created by LeeX on 10/1/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager
class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, Delegate {

    @IBOutlet weak var tableView: UITableView!
    
    var restaurants:[Restaurant] = []
    
    var businesses: [Business]!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredArray:[Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
        }
        )
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveData(data: [Restaurant]) {
        self.restaurants = data
        self.tableView.reloadData()
    }
    
    func filterContentForSearchText (searchText: String) {
        filteredArray = restaurants.filter({ (restaurant) -> Bool in
            return restaurant.name.lowercased().contains(searchText.lowercased())
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
            return self.restaurants.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.Name.text = filteredArray[indexPath.row].name
        } else {
            cell.Name.text = self.restaurants[indexPath.row].name
        }
        cell.Address.text = self.restaurants[indexPath.row].address
        cell.Kinds.text = self.restaurants[indexPath.row].kind
        let imgURL = NSURL(string: self.restaurants[indexPath.row].image)
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.restaurantImage.image = UIImage(data: data as! Data)
        }
        return cell
    }
}



