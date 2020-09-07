//
//  CustomViewTableViewCell.swift
//  IDIAZM_Example
//
//  Created by Iván Díaz Molina on 07/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CustomViewTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
