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
    
    var businesses: [Business]!

    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredArray:[Restaurant] = []
    
    var switchSelected:[String] = []
    
    var distanceSelected:String = ""
    
    var sortBySelected:String = ""
    
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
            self.animateTable()
            //self.tableView.reloadData()
            
        }
        )
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animateTableAfterFilter()
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
            cell.Name.text = filteredArray[indexPath.row].name
            cell.Address.text = filteredArray[indexPath.row].address
            cell.Kinds.text = self.filteredArray[indexPath.row].kind
            cell.ReviewCount.text = self.filteredArray[indexPath.row].reviewCount
            let reviewImgURL = NSURL(string: self.filteredArray[indexPath.row].reviewImage)
            
            if reviewImgURL != nil {
                let data = NSData(contentsOf: (reviewImgURL as? URL)!)
                cell.ReviewImage.image = UIImage(data: data as! Data)
            }
            
            let imgURL = NSURL(string: self.filteredArray[indexPath.row].image)
            
            if imgURL != nil {
                let data = NSData(contentsOf: (imgURL as? URL)!)
                cell.restaurantImage.image = UIImage(data: data as! Data)
            }
        } else {
            cell.Name.text = self.restaurants[indexPath.row].name
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
        }
        return cell
    }
    
    func didReceiveSwitchData(switchSelected: [String]) {
        self.switchSelected = switchSelected
        filterContentForSearchText(searchText: searchController.searchBar.text ?? "")
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
    
    func animateTable() {
        self.tableView.reloadData()
        let cells = tableView.visibleCells
        
//        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
//            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
              cell.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
        
        for cell in cells {
            //            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            cell.transform = CGAffineTransform(scaleX: -2, y: -2)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.25, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    func animateTableAfterFilter() {
        self.tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableViewWidth = tableView.bounds.size.width
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: tableViewWidth, y: 0)
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



