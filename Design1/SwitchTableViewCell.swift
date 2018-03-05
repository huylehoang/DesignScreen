//
//  SwitchTableViewCell.swift
//  Design1
//
//  Created by LeeX on 1/14/18.
//  Copyright © 2018 LeeX. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func mySwitchTapped(cell: SwitchTableViewCell)
}

protocol SwitchLabelDelegate: class {
    func didReveiText(text: String)
}

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    
    var labelDelegate: SwitchLabelDelegate?
    var delegate: SwitchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    @IBAction func someSwitchTapped(_ sender: Any) {
        updateMySwitchState()
        self.delegate?.mySwitchTapped(cell: self)
    }

    
    func updateMySwitchState() {
        if toggle.isOn {
            print("isOn")
            print(switchLabel.text!)
            self.labelDelegate?.didReveiText(text: switchLabel.text!)
        } else {
            print("isOff")
        }
    }
    
}
