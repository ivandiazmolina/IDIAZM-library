//
//  UICollectionViewCell+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 14/09/2020.
//

import UIKit

public extension UICollectionViewCell {
    
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
