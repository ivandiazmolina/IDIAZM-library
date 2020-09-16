//
//  UIView+Additions.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 04/09/2020.
//

import UIKit

/// NIBs
public extension UIView {
    
    // MARK: public methods
    
    /// Load a view from a nib with the same filename.
    ///
    /// - Returns: An empty View if the View is not found
    ///
    /// Usage:
    ///
    ///     class CustomView: UIView {
    ///     
    ///         //MARK: - Initializers
    ///         override init(frame: CGRect) {
    ///             super.init(frame: frame)
    ///             xibSetup()
    ///         }
    ///
    ///         required init?(coder aDecoder: NSCoder) {
    ///             super.init(coder: aDecoder)
    ///             xibSetup()
    ///         }
    ///
    func xibSetup() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    // MARK: VARS
    static var nib: UINib {
        let bundle = Bundle(for: self)
        return UINib(nibName: String(describing: self), bundle: bundle)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: private methods
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            return view
        }
        return UIView()
    }
}
