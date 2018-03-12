//
//  Data.swift
//  Design1
//
//  Created by LeeX on 3/12/18.
//  Copyright © 2018 LeeX. All rights reserved.
//

import Foundation

//protocol RestaurantDataDelegate: class {
//    func
//}

class RestaurantData {
    var dataLoaded : (([Restaurant]) -> ())?
    
    func fetchData() {
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
//            self.businesses = businesses
            
            var newRestaurants = [Restaurant]()
            
            if let businesses = businesses {
                for business in businesses {
                    let imageURL = business.imageURL!
                    
                    let image = "\(imageURL)"
                    
                    let reviewImageURL = business.ratingImageURL!
                    
                    let reviewImage = "\(reviewImageURL)"
                    
                    let reviewCount = business.reviewCount!
                    
                    let reviewCountString = String(describing: reviewCount) + " Reviews"
                    
                    print(business.distance!)
                    
                    newRestaurants.append(Restaurant(name: business.name!, address: business.address!, kind: business.categories, image: image, reviewImage: reviewImage, reviewCount: reviewCountString, distance: business.distance!))
                    
                }
            }
            self.dataLoaded?(newRestaurants)
            
        })
    }
}
