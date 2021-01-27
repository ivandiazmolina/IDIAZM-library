//
//  UIScrollView+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 20/9/20.
//

import Foundation

public extension UIScrollView {
    
    /// Get the current page
    var currentPage: Int {
        return Int(self.contentOffset.x / self.frame.size.width)
    }
}
