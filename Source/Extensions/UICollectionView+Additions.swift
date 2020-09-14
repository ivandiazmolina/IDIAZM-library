//
//  UICollectionView+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 14/09/2020.
//

import UIKit

public extension UICollectionView {
    
    /// Register a cell in the CollectionView
    ///
    ///
    /// Usage:
    ///
    ///     collectionView.register(CustomCell.self)
    ///
    /// - Parameter type: The custom cell that you want register
    ///
    func register<T: UICollectionViewCell> (_ type: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.nibName)
    }
}
