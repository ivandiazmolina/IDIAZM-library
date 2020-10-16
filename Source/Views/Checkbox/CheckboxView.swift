//
//  CheckboxView.swift
//  IDIAZM
//
//  Created by David Manuel Fernández Suárez on 16/10/2020.
//

import UIKit

open class CheckboxView: UIView {
        
    // MARK: VARS
    
    private var on: Bool = false {
        didSet {
            check.isHidden = !on
        }
    }
    
    private var checkContainer: UIView = {
        let view: UIView = UIView()
        view.layer.borderWidth = 1
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private var check: CheckImage = {
        let view: CheckImage = CheckImage()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        return view
    }()
    
    // MARK: Public methods
    
    /// Update checkbox component
    /// - Parameters:
    ///   - on: true -> show checkbox, false -> hide checkbox
    public func updateUI(on: Bool) {
        self.on = on
    }
    
    // MARK: Private methods
            
    private func setupView() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(change)))
        on = false
    }
        
    open override func layoutSubviews() {
        super.layoutSubviews()
        addViews()
        addConstraints()
    }
    
    private func addViews() {
        addSubview(checkContainer)
        checkContainer.addSubview(check)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            checkContainer.widthAnchor.constraint(equalToConstant: frame.width),
            checkContainer.heightAnchor.constraint(equalToConstant: frame.width),
            checkContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            check.leadingAnchor.constraint(equalTo: checkContainer.leadingAnchor, constant: 0),
            check.trailingAnchor.constraint(equalTo: checkContainer.trailingAnchor, constant: 0),
            check.topAnchor.constraint(equalTo: checkContainer.topAnchor, constant: 0),
            check.bottomAnchor.constraint(equalTo: checkContainer.bottomAnchor, constant: 0)
        ])
    }
    
    @objc private func change() {
        on = !on
    }
    
    // MARK: Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
}
