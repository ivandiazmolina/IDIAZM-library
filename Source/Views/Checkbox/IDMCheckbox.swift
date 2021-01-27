//
//  Checkbox.swift
//  Pods
//
//  Created by David Manuel Fernández Suárez on 16/10/2020.
//

import UIKit

open class Checkbox: UIView {
    
    // MARK: LETS
    
    private let SIZE_CHECKBOX: CGFloat = 20

    // MARK: VARS
    
    private var on: Bool = false {
        didSet {
            checkbox.updateUI(on: on)
        }
    }
    
    private var checkbox: CheckboxView = {
        let view: CheckboxView = CheckboxView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var label: UILabel = {
        let view: UILabel = UILabel()
        view.text = "Label checkbox"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Public methods
    
    /// Update checkbox component
    /// - Parameters:
    ///   - on: true -> show checkbox, false -> hide checkbox
    ///   - text: Text of checkbox
    public func updateUI(on: Bool, text: String? = nil) {
        self.on = on
        guard let text = text else { return }
        label.text = text
    }
    
    // MARK: Private methods
    
    private func setupView() {
        addSubview(checkbox)
        addSubview(label)
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkbox.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: SIZE_CHECKBOX),
            checkbox.heightAnchor.constraint(equalTo: checkbox.widthAnchor),
            label.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: SIZE_CHECKBOX),
            label.centerYAnchor.constraint(equalTo: checkbox.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: SIZE_CHECKBOX)
        ])
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(change)))
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
