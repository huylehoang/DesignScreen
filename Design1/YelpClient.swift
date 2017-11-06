//
//  YelpClient.swift
//  Design1
//
//  Created by LeeX on 10/23/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import AFNetworking
import BDBOAuth1Manager

// You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"

protocol Delegate: class {
    func didReceiveData(data: [Restaurant])
}

enum YelpSortMode: Int {
    case bestMatched = 0, distance, highestRated
}

class YelpClient: BDBOAuth1RequestOperationManager {
    
    var delegate: Delegate?
    
    var accessToken: String!
    var accessSecret: String!
    
    static let sharedInstance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        let baseUrl = URL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(_ term: String, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        return searchWithTerm(with: term, sort: nil, categories: nil, deals: nil, completion: completion)
    }
    
    func searchWithTerm(with term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completion: @escaping ([Business]?, Error?) -> ()) -> AFHTTPRequestOperation {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        // Default the location to San Francisco
        var parameters: [String : AnyObject] = ["term": term as AnyObject, "ll": "37.785771,-122.406165" as AnyObject]
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue as AnyObject?
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["category_filter"] = (categories!).joined(separator: ",") as AnyObject?
        }
        
        if deals != nil {
            parameters["deals_filter"] = deals! as AnyObject?
        }
        
        print(parameters)
        
        var restaurants:[Restaurant] = []
        
        return self.get("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation, response: Any) in
            if let response = response as? NSDictionary {
                let dictionaries = response["businesses"] as? [NSDictionary]
                var newRestaurants = [Restaurant]()
                
                if dictionaries != nil {
//                    completion(Business.businesses(array: dictionaries!), nil)
                    for dictionary in dictionaries! {
                        let location = dictionary["location"] as! NSDictionary
                        let display_address = location["display_address"]! as! NSArray
                        let address = "\(display_address[0])" + "," + " \(display_address[1])"
                        let name = dictionary["name"]! as! String
                        let categories = dictionary["categories"] as! NSArray
                        var arr1:[String] = []
                        for category in categories {
                            let arr = category as! NSArray
                            arr1.append(arr[0] as! String)
                        }
                        let str = arr1.joined(separator: ", ")
                        let kind = str 
                        let image = dictionary["image_url"]! as! String
                        
                        newRestaurants.append(Restaurant(name: name, address: address, kind: kind, image:image))
                    }
                    restaurants = newRestaurants
                    print(restaurants)
                    self.delegate?.didReceiveData(data: restaurants)
                    
                }
            }
        }, failure: { (operation: AFHTTPRequestOperation?, error: Error) in
            completion(nil, error)
        })!
    }
}
