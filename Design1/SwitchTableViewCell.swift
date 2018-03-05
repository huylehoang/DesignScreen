//
//  SwitchTableViewCell.swift
//  Design1
//
//  Created by LeeX on 1/14/18.
//  Copyright © 2018 LeeX. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func mySwitchTapped(cell: SwitchTableViewCell, switchState: Bool, switchLabel: String)
}

class SwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    
    var delegate: SwitchTableViewCellDelegate?
    
    var switchTapAction : ((Bool)->Void)?
    
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
        switchTapAction?((sender as AnyObject).isOn)
        self.delegate?.mySwitchTapped(cell: self, switchState: toggle.isOn, switchLabel: switchLabel.text!)
    }

    
    func updateMySwitchState() {
        if toggle.isOn {
            print("Switch State is On")
        } else {
            print("Switch State is OFF")
        }
    }
    
}
