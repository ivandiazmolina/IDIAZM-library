//
//  Threads.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 05/09/2020.
//

/// Execute a function on UI Thread
///
/// - Parameter f: function
///
/// Usage:
///
///     ui { [weak self] in
///         your code here...
///     }
///
/// Execute a function on UI Thread
/// - Parameter f: function
public func ui(_ f: @escaping () -> Void) {
    
    DispatchQueue.main.async {
        f()
    }
}

/// Execute a function on Background Thread
///
/// - Parameter f: function
///
/// Usage:
///
///     background { [weak self] in
///         your code here...
///     }
///
/// Execute a function on UI Thread
/// - Parameter f: function
public func background(_ f: @escaping () -> Void) {
    
    DispatchQueue.global(qos: .background).async {
        f()
    }
}
