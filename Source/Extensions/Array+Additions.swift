//
//  Array+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 04/09/2020.
//

import UIKit
extension Array {
    
    // MARK: public methods
    
    /// Get the element at index from array
    ///
    /// - Returns: Return the element if exists, otherwise nil
    ///
    /// Usage:
    ///
    ///     let titles = [
    ///         "element1",
    ///         "element2",
    ///         "element3"
    ///     ]
    ///
    ///     print(titles.getElement(1)) // index 1 --> element2
    ///     print(titles.getElement(3)) // index out --> nil
    ///
    /// - Parameter index: element position of array
    ///
    func getElement(_ index: Int) -> Element? {
        guard index >= 0, index < self.count else {
            return nil
        }
        return self[index]
    }
}
