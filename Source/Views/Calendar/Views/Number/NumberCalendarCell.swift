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
}
