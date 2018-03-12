//
//  UITableViewExtension.swift
//  Design1
//
//  Created by LeeX on 3/12/18.
//  Copyright © 2018 LeeX. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func animateTableAfterFilter() {
        self.reloadData()
        let cells = self.visibleCells
        
        let tableViewWidth = self.bounds.size.width
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: tableViewWidth, y: 0)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 0.4, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    func animateTable() {
        self.reloadData()
        let cells = self.visibleCells
        
        for cell in cells {
            cell.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
        
        for cell in cells {
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
}
