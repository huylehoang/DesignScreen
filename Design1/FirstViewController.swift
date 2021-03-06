//
//  FirstViewController.swift
//  Design1
//
//  Created by LeeX on 10/1/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, FilterViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var restaurants:[Restaurant] = []
    
//    var businesses: [Business]!

    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredArray:[Restaurant] = []
    
    var switchSelected:[String] = []
    
    var distanceSelected:String = ""
    
    var sortBySelected:String = ""
    
    var data = RestaurantData()
    
    var cell = TableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        data.fetchData()
        data.dataLoaded = { [unowned self] newRestaurants in
            self.restaurants = newRestaurants
            self.tableView.animateTable()
        }
        
//        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
//
//            var newRestaurants = [Restaurant]()
//
//            if let businesses = businesses {
//                for business in businesses {
//                    let imageURL = business.imageURL!
//
//                    let image = "\(imageURL)"
//
//                    let reviewImageURL = business.ratingImageURL!
//
//                    let reviewImage = "\(reviewImageURL)"
//
//                    let reviewCount = business.reviewCount!
//
//                    let reviewCountString = String(describing: reviewCount) + " Reviews"
//
//                    print(business.distance!)
//
//                    newRestaurants.append(Restaurant(name: business.name!, address: business.address!, kind: business.categories, image: image, reviewImage: reviewImage, reviewCount: reviewCountString, distance: business.distance!))
//
//                }
//            }
//
//            self.restaurants = newRestaurants
//            self.animateTable()
//            //self.tableView.reloadData()
//
//        }
//        )
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func filterContentForSearchText (searchText: String) {
        if switchSelected.count != 0  {
            filteredArray = restaurants.filter({ (restaurant) -> Bool in
//                print(restaurant.kind.lowercased(), "  " , switchLabel.lowercased())
                var check = 0
                for i in switchSelected {
                    if restaurant.kind.lowercased().contains(i.lowercased()) {
                        check += 1
                    }
                }
                if searchText != "" {
//                    print(restaurant.name.lowercased().contains(searchText.lowercased()), searchText)
                   return restaurant.name.lowercased().contains(searchText.lowercased()) && check == switchSelected.count
                } else {
                    return (check == switchSelected.count)
                }
            })
        } else {
            filteredArray = restaurants.filter({ (restaurant) -> Bool in
                return restaurant.name.lowercased().contains(searchText.lowercased())
            })
        }
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text ?? "")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" || switchSelected.count != 0  {
            return self.filteredArray.count
        } else {
            return self.restaurants.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        
        if searchController.isActive && searchController.searchBar.text != "" || switchSelected.count != 0 {
            cell.addCell(Name: filteredArray[indexPath.row].name
                , Address: filteredArray[indexPath.row].address
                , Kinds: filteredArray[indexPath.row].kind
                , ReviewCount: filteredArray[indexPath.row].reviewCount
                , Distance: filteredArray[indexPath.row].distance
                , ReviewImage: filteredArray[indexPath.row].reviewImage
                , restaurantImage: filteredArray[indexPath.row].image)
        } else {
            cell.addCell(Name: self.restaurants[indexPath.row].name
                , Address: self.restaurants[indexPath.row].address
                , Kinds: self.restaurants[indexPath.row].kind
                , ReviewCount: self.restaurants[indexPath.row].reviewCount
                , Distance: self.restaurants[indexPath.row].distance
                , ReviewImage: self.restaurants[indexPath.row].reviewImage
                , restaurantImage: self.restaurants[indexPath.row].image)
        }
        return cell
    }
    
    func didReceiveSwitchData(switchSelected: [String]) {
        self.switchSelected = switchSelected
        filterContentForSearchText(searchText: searchController.searchBar.text ?? "")
        self.tableView.animateTableAfterFilter()
    }
    
    func didReceiveDistanceData(distanceSelected: String) {
        self.distanceSelected = distanceSelected
    }
    
    func didReceiveSortByData(sortBySelected: String) {
        self.sortBySelected = sortBySelected
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FilterViewController
        vc.filterDelegate = self
//        vc.firstController = self
        vc.switchCategorySelected = self.switchSelected
        vc.distanceSelected = self.distanceSelected
        vc.sortBySelected = self.sortBySelected
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
    }

    @IBAction func btnFilterClicked(_ sender: Any) {
        performSegue(withIdentifier: "moveToFilterVC", sender: self)
    }
}



