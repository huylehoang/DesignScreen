//
//  DropTableViewCell.swift
//  Design1
//
//  Created by LeeX on 1/14/18.
//  Copyright © 2018 LeeX. All rights reserved.
//

import UIKit

class DropTableViewCell: UITableViewCell {

    @IBOutlet weak var dropLabel: UILabel!
    
    @IBOutlet weak var drop: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
