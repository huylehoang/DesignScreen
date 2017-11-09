//
//  TableViewCell.swift
//  Design1
//
//  Created by LeeX on 10/1/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ReviewCount: UILabel!
    @IBOutlet weak var ReviewImage: UIImageView!
    @IBOutlet weak var Kinds: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var Reviews: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
