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
    
    open override func layoutIfNeeded() {
        super.layoutIfNeeded()
        numberLabel.round()
    }
    
    fileprivate func setupView() {
        numberLabel.text = ""
    }
    
    /// Update UI of cell
    /// - Parameter date: date
    func updateUI(date: Date, data: CalendarData) {
        
        setNeedsLayout()
        layoutIfNeeded()
        
        // text
        numberLabel.text = String(describing: date.day)
                
        // text color
        if data.currentDate.startOfDay == date.startOfDay {
            numberLabel.textColor = .white
            numberLabel.backgroundColor = .red
        } else if data.selectedDate == date {
            numberLabel.textColor = .white
            numberLabel.backgroundColor = .blue
        } else {
            numberLabel.textColor = Calendar.currentUTC.month == date.month ? .black : .gray
            numberLabel.backgroundColor = .white
        }
    }
}
