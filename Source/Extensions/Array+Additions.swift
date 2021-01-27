//
//  Array+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 04/09/2020.
//

import UIKit

public extension Array {
    
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
    ///     let elements = titles.chunked(into: 1)
    ///     print(elements.getElement(0)) // index 0 --> element1
    ///     print(elements.getElement(2)) // index 2 --> element3
    ///
    /// - Parameter index: element position of array
    ///
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
