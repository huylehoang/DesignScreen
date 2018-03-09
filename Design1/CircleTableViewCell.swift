//
//  CircleTableViewCell.swift
//  Design1
//
//  Created by LeeX on 1/14/18.
//  Copyright © 2018 LeeX. All rights reserved.
//

import UIKit

protocol CircleTableViewCellDelegate: class {
    func didSelected(cell: CircleTableViewCell, string: String)
}

enum CircleCellType {
    case distance
    case sortBy
}

class CircleTableViewCell: UITableViewCell {
    
    var circleDelegate: CircleTableViewCellDelegate?

    @IBOutlet weak var circleLabel: UILabel!
    @IBOutlet weak var circle: UIImageView!
    var type : CircleCellType = .distance
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.circleDelegate?.didSelected(cell: self, string: circleLabel.text!)
        }
    }
}
