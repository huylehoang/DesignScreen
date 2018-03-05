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

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, SwitchTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var restaurants:[Restaurant] = []
    
    var businesses: [Business]!

    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredNameArray:[Restaurant] = []
    
    var switchState = Bool()
    var switchLabel = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            
            var newRestaurants = [Restaurant]()
            
            if let businesses = businesses {
                for business in businesses {
                    
                    let imageURL = business.imageURL!
                    
                    let image = "\(imageURL)"
                    
                    let reviewImageURL = business.ratingImageURL!
                    
                    let reviewImage = "\(reviewImageURL)"
                    
                    let reviewCount = business.reviewCount!
                    
                    let reviewCountString = String(describing: reviewCount) + " Reviews"
                    
                    newRestaurants.append(Restaurant(name: business.name!, address: business.address!, kind: business.categories, image: image, reviewImage: reviewImage, reviewCount: reviewCountString))
                    
                }
            }
            
            self.restaurants = newRestaurants
            self.tableView.reloadData()
            
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
    
    func filterContentForSearchText (searchText: String) {
        filteredNameArray = restaurants.filter({ (restaurant) -> Bool in
            return restaurant.name.lowercased().contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.filteredNameArray.count
        } else {
            return self.restaurants.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.Name.text = filteredNameArray[indexPath.row].name
        } else {
            cell.Name.text = self.restaurants[indexPath.row].name
        }
        cell.Address.text = self.restaurants[indexPath.row].address
        cell.Kinds.text = self.restaurants[indexPath.row].kind
        cell.ReviewCount.text = self.restaurants[indexPath.row].reviewCount
        
        let reviewImgURL = NSURL(string: self.restaurants[indexPath.row].reviewImage)
        
        if reviewImgURL != nil {
            let data = NSData(contentsOf: (reviewImgURL as? URL)!)
            cell.ReviewImage.image = UIImage(data: data as! Data)
        }
        
        let imgURL = NSURL(string: self.restaurants[indexPath.row].image)
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.restaurantImage.image = UIImage(data: data as! Data)
        }
        return cell
    }
    

    
    func mySwitchTapped(cell: SwitchTableViewCell, switchState: Bool, switchLabel: String) {

        
        //  Do whatever you need to do with the indexPath
        self.switchState = switchState
        self.switchLabel = switchLabel
        print(switchState)
        print(switchLabel)
        
        print("Button tapped on row")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FilterViewController
        vc.firstController = self
    }
    
    
}



