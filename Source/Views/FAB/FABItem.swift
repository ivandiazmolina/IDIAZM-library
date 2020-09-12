//
//  FABItem.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 11/09/2020.
//

import UIKit

public typealias FABItemAction = (FABItem) -> Void

open class FABItem: NSObject {
    
    // MARK: VIEWS
    
    /// View that will hold the item's button and label
    internal var view: UIView!
    
    /// Label that contain the item's *text*
    fileprivate var label: UILabel!
    
    /// Main button that will perform the defined action
    fileprivate var button: UIButton!
    
    /// Image used by the button
    fileprivate var image: UIImage!
    
    fileprivate var labelBackground: UIView!
    
    
    // MARK: LETS
    
    // MARK: VIEW PROPERTIES
    
    /// Size needed for the *view* property presente the item's content
    fileprivate let VIEW_SIZE = CGSize(width: 200, height: 35)
    
    
    // MARK: BUTTON PROPERTIES
    
    /// Button size
    fileprivate let BUTTON_SIZE = CGSize(width: 35, height: 35)
    
    /// Button shadow opacity
    fileprivate let BUTTON_SHADOW_OPACITY: Float = 1.0
    
    /// Button shadow radius
    fileprivate let BUTTON_SHADOW_RADiUS: CGFloat = 2.0
    
    /// Button shadow offset
    fileprivate let BUTTON_SHADOW_OFFSET = CGSize(width: 1, height: 1)
    
    /// Button shadow color
    fileprivate let BUTTON_SHADOW_COLOR: CGColor = UIColor.gray.cgColor
    
    
    // MARK: BACKGROUND PROPERTIES
    
    /// Background insert
    fileprivate let BACKGROUND_INSET = CGSize(width: 10, height: 10)
    
    
    // MARK: LABEL PROPERTIES
    
    /// Label position
    /// - Important: value must be positive
    fileprivate let LABEL_POSITION: CGFloat = 130
    
    /// Label color
    fileprivate let LABEL_COLOR: UIColor = .darkGray
    
    /// Label alignment
    fileprivate let LABEL_ALIGNMENT: NSTextAlignment = .right
    
    /// Label font size
    fileprivate let LABEL_FONT_SIZE: CGFloat = 13
    
    
    // MARK: LABELBACKGROUND PROPERTIES
    
    /// LabelBackground background
    fileprivate let LABELBACKGROUND_BACKGROUND: UIColor = .white
    
    /// LabelBackground radius
    fileprivate let LABELBACKGROUND_RADIUS: CGFloat = 3
    
    /// LabelBackground shadow opacity
    fileprivate let LABELBACKGROUND_SHADOW_OPACITY: Float = 0.8
    
    /// LabelBackground shadow offset
    fileprivate let LABELBACKGROUND_SHADOW_OFFSET: CGSize = CGSize(width: 0, height: 1)
    
    /// LabelBackground shadow radius
    fileprivate let LABELBACKGROUND_SHADOW_RADIUS: CGFloat = 0.2
    
    /// LabelBackground shadow color
    fileprivate let LABELBACKGROUND_SHADOW_COLOR: CGColor = UIColor.lightGray.cgColor
    
    
    // MARK: VARS
    
    /// The action the item should perform when tapped
    open var action: FABItemAction?
    
    /// Description of the item's action
    open var text: String = ""
    
    
    // MARK: INIT
    
    /// Constructor
    /// - Parameter optionalTitle: title of item
    /// - Parameter image: image of item
    public init(title text: String?, image: UIImage?) {
        super.init()
        
        // setup view
        setupView()
                
        // setup button
        setupButton(image)
        
        // setup label
        setupLabel(text)
    }
    
    // MARK: Public Methods
    
    /// Method that is launched when the button is pressed
    /// - Parameter sender: UIButton
    @objc func buttonPressed(_ sender: UIButton) {
        guard let action = action else { return }
        action(self)
    }
    
    /// Method that is launched when the label is tapped
    /// - Parameter gesture: UIGestureRecognizer
    @objc func labelTapped(_ gesture: UIGestureRecognizer) {
        guard let action = action else { return }
        action(self)
    }
    
    // MARK: Private Methods
    
    /// Setup the view
    fileprivate func setupView() {
        view = UIView(frame: CGRect(origin: CGPoint.zero, size: VIEW_SIZE))
        view.alpha = 0
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.clear
    }
    
    /// Setup the button
    fileprivate func setupButton(_ image: UIImage?) {
        
        button = UIButton(type: .custom)
        button.frame = CGRect(origin: CGPoint(x: VIEW_SIZE.width - BUTTON_SIZE.width, y: 0), size: BUTTON_SIZE)
        button.layer.shadowOpacity = BUTTON_SHADOW_OPACITY
        button.layer.shadowRadius = BUTTON_SHADOW_RADiUS
        button.layer.shadowOffset = BUTTON_SHADOW_OFFSET
        button.layer.shadowColor = BUTTON_SHADOW_COLOR
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        if let unwrappedImage = image {
            button.setImage(unwrappedImage, for: UIControl.State())
        }
        
        view.addSubview(button)
    }
    
    /// Setup the label
    /// - Parameter title: optional text for title
    fileprivate func setupLabel(_ title: String?) {
        
        guard let text = title, !text.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty else { return }
        
        label = UILabel()
        
        // LABEL
        label.font = UIFont.systemFont(ofSize: LABEL_FONT_SIZE)
        
        label.textColor = LABEL_COLOR
        label.textAlignment = LABEL_ALIGNMENT
        label.text = text
        
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:))))
        label.sizeToFit()
        
        // LABELBACKGROUND
        labelBackground = UIView()
        labelBackground.frame = label.frame
        labelBackground.backgroundColor = LABELBACKGROUND_BACKGROUND
        labelBackground.layer.cornerRadius = LABELBACKGROUND_RADIUS
        labelBackground.layer.shadowOpacity = LABELBACKGROUND_SHADOW_OPACITY
        labelBackground.layer.shadowOffset = LABELBACKGROUND_SHADOW_OFFSET
        labelBackground.layer.shadowRadius = LABELBACKGROUND_SHADOW_RADIUS
        labelBackground.layer.shadowColor = LABELBACKGROUND_SHADOW_COLOR
        
        // Adjust the label's background inset
        labelBackground.frame.size.width = label.frame.size.width + BACKGROUND_INSET.width
        labelBackground.frame.size.height = label.frame.size.height + BACKGROUND_INSET.height
        label.frame.origin.x = label.frame.origin.x + BACKGROUND_INSET.width / 2
        label.frame.origin.y = label.frame.origin.y + BACKGROUND_INSET.height / 2
        
        // Adjust label's background position
        labelBackground.frame.origin.x = CGFloat(LABEL_POSITION - label.frame.size.width)
        labelBackground.center.y = view.center.y
        labelBackground.addSubview(label)
        
        // Add Tap Gestures Recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        view.addGestureRecognizer(tap)
        
        view.addSubview(labelBackground)
    }
}
