//
//  IntrinsicHeightTableView.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 05/09/2020.
//

import UIKit

open class IntrinsicHeightTableView: UITableView {
    
    var contentSizeBool = true
    
    open override var contentSize: CGSize {
        didSet {
            if contentSizeBool {
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    open override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }
    
    open override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
