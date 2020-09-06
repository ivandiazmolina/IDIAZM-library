//
//  IntrinsicHeightTableView.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 05/09/2020.
//

import UIKit

class IntrinsicHeightTableView: UITableView {
    
    var contentSizeBool = true
    override var contentSize: CGSize {
        didSet {
            if contentSizeBool {
                invalidateIntrinsicContentSize()
            }
        }
    }
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: contentSize.height)
    }
}
