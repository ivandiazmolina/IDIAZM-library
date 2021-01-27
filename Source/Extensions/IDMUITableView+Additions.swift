//
//  UITableView+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 04/09/2020.
//

import UIKit

public extension UITableView {
    
    /// Register a cell in the TableView
    ///
    ///
    /// Usage:
    ///
    ///     tableView.register(CustomCell.self)
    ///
    /// - Parameter type: The custom cell that you want register
    ///
    func register<T: UITableViewCell> (_ type: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
}
