//
//  TableViewCell.swift
//  Design1
//
//  Created by LeeX on 10/1/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ReviewCount: UILabel!
    @IBOutlet weak var ReviewImage: UIImageView!
    @IBOutlet weak var Kinds: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var Distance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addCell(Name: String!, Address: String!, Kinds: String!, ReviewCount: String!, Distance: String!, ReviewImage: String!, restaurantImage: String!) {
        self.Name.text = Name
        self.Address.text = Address
        self.Kinds.text = Kinds
        self.ReviewCount.text = ReviewCount
        self.Distance.text = Distance
        
        Alamofire.request(ReviewImage).responseImage { response in
            if let reviewImage = response.result.value {
                self.ReviewImage.image = reviewImage
            }
        }
//        let reviewImgURL = NSURL(string: ReviewImage)
//        if reviewImgURL != nil {
//            let data = NSData(contentsOf: (reviewImgURL as URL?)!)
//            self.ReviewImage.image = UIImage(data: data! as Data)
//        }
        
        Alamofire.request(restaurantImage).responseImage { response in
            if let image = response.result.value {
                self.restaurantImage.image = image
            }
        }
        
//        let imgURL = NSURL(string: restaurantImage)
//        if imgURL != nil {
//            let data = NSData(contentsOf: (imgURL as URL?)!)
//            self.restaurantImage.image = UIImage(data: data! as Data)
//        }
    }
}
