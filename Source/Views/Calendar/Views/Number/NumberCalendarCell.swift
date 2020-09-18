//
//  NumberCalendarCell.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 13/09/2020.
//  Copyright © 2020 IDIAZM. All rights reserved.
//

import UIKit

open class NumberCalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    fileprivate func setupView() {
        numberLabel.text = ""
    }
    
    /// Update UI of cell
    /// - Parameter date: date
    func updateUI(date: Date) {
        
        // text
        numberLabel.text = String(describing: date.day)
        
        // text color
        if Calendar.currentUTC.day == date.day {
            numberLabel.textColor = .red
        } else {
            numberLabel.textColor = Calendar.currentUTC.month == date.month ? .black : .gray
        }
    }
}
