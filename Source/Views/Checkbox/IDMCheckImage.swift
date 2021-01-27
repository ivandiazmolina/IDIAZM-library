//
//  CheckImage.swift
//  IDIAZM
//
//  Created by David Manuel Fernández Suárez on 16/10/2020.
//

import UIKit

open class CheckImage: UIView {
    
    // MARK: VARS
    
    private lazy var factor: CGFloat = 0.1 * frame.width
    
    private var color: UIColor = .black
    
    // MARK: Private methods
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    public override func draw(_ rect: CGRect) {
        setupFormat()
        setupPath(rect: rect)
    }
    
    private func setupFormat() {
        color.setStroke()
    }
    
    private func setupPath(rect: CGRect) {
        
        /// Draw path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: factor, y: rect.height * 3/4))
        path.addLine(to: CGPoint(x: rect.width/2, y: rect.height - factor))
        path.move(to: CGPoint(x: rect.width/2, y: rect.height - factor))
        path.addLine(to: CGPoint(x: rect.width - factor, y: factor))
        
        /// Setup path format
        path.lineWidth = factor
        path.lineCapStyle = .round
        path.stroke()
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
