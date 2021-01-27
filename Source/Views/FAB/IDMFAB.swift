//
//  FAB.swift
//  IDIAZM
//
//  Created by Iván Díaz Molina on 11/09/2020.
//

import UIKit

public typealias FABAction = (FAB) -> Void

open class FAB: NSObject {
    
    // MARK: VIEWS
    
    /// The button that will be presented to the user
    fileprivate var fab: UIButton!
    
    /// View that will hold the placement of the button's actions
    fileprivate var contentView: UIView!
    
    /// View where the FAB will be displayed
    fileprivate var parentView: UIView!
    
    /// Blur effect that will be presented when the button is active
    fileprivate var blurVisualEffect: UIVisualEffectView!
    
    
    // MARK: LETS
    
    // MARK: ITEM PROPERTIES
    
    /// Distance X between items
    /// - Important: value must be negative
    fileprivate let ITEM_OFFSET_X: CGFloat = -83
    
    /// Distance Y between items
    /// - Important: value must be negative
    fileprivate let ITEM_OFFSET_Y: CGFloat = -55
    
    /// Separations of items
    fileprivate let SEPARATION_ITEMS: CGFloat = 0.9
    
    // MARK: BUTTON PROPERTIES
    
    /// Button radius
    fileprivate let BUTTON_RADIUS: CGFloat = 50
    
    /// Button font size
    fileprivate let BUTTON_FONT_SIZE: CGFloat = 35
    
    
    // MARK: FAB PROPERTIES
    
    /// FAB trailing
    fileprivate let FAB_TRAILING: CGFloat = -16.0
    
    /// FAB bottom
    fileprivate let FAB_BOTTOM: CGFloat = -16.0
    
    /// FAB shadow opacity
    fileprivate let FAB_SHADOW_OPACITY: Float = 1.0
    
    /// FAB shadow radius
    fileprivate let FAB_SHADOW_RADIUS: CGFloat = 2.0
    
    /// FAB shadow offset
    fileprivate let FAB_SHADOW_OFFSET = CGSize(width: 1, height: 1)
    
    /// FAB shadow color
    fileprivate let FAB_SHADOW_COLOR: CGColor = UIColor.gray.cgColor
    
    /// FAB animation duration
    fileprivate let ANIMATION_DURATION: CGFloat = 0.2
    
    /// FAB scale tapped
    fileprivate let SCALE_TAPPED: CGFloat = 1.0
    
    /// FAB scale touch down
    fileprivate let SCALE_TOUCHDOWN: CGFloat = 0.9
    
    /// FAB UIEdgeInsets
    fileprivate let FAB_EDGEINSETS: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0)
    
    
    // MARK: VARS
    
    /// The action the button should perform when tapped
    open var action: FABAction?
    
    /// An array of items that the button will present
    internal var items: [FABItem]? {
        
        willSet {
            guard let items = items else { return }
            for tmp in items {
                tmp.view.removeFromSuperview()
            }
        }
        
        didSet {
            addButtonItems()
            show(active: true)
        }
    }
    
    /// The background color of floating action button
    open var backgroundColor: UIColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha:1.0) {
        willSet {
            fab.backgroundColor = newValue
            backgroundColorSelected = newValue
        }
    }
    
    /// The background color of floating action button when this is selected
    open var backgroundColorSelected: UIColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha:1.0)
    
    /// Indicates if the buttons is active
    fileprivate(set) open var active: Bool = false
    
    /// The bottom position of fab. Default 16
    fileprivate(set) open var bottom: CGFloat = 16.0
    
    /// The trailing position of fab. Default 16
    fileprivate(set) open var trailing: CGFloat = 16.0
    
    
    // MARK: INIT
    
    /// Constructor
    /// - Parameter view: View where the FAB will be displayed
    /// - Parameter items: items of FAB
    /// - Parameter bottom: bottom position of FAB. Default 16
    /// - Parameter trailing: trailing position of FAB. Default 16
    public init(attachedToView view: UIView, items: [FABItem]?, bottom: CGFloat = 16, trailing: CGFloat = 16) {
        
        super.init()
        
        // init parent View
        parentView = view
        
        // init items
        self.items = items
        
        // init bottom and trailing
        self.bottom = -bottom
        self.trailing = -trailing
        
        // setup View
        self.setupView()
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Public Methods
    
    /// Set title to fab
    /// - Parameter title: title
    /// - Parameter state: state
    open func setTitle(_ title: String?, forState state: UIControl.State) {
        
        fab.setImage(nil, for: state)
        fab.setTitle(title, for: state)
        fab.contentEdgeInsets = FAB_EDGEINSETS
    }
    
    /// Set a custom font to title, otherwise set a system font with default font size
    /// - Parameter font: font
    /// - Parameter size: size
    open func setFont(_ font: UIFont?) {
        
        guard let font = font else {
            fab.titleLabel?.font = UIFont.systemFont(ofSize: BUTTON_FONT_SIZE)
            return
        }
        
        fab.titleLabel?.font = font
    }
    
    /// Set image to fab
    /// - Parameter image: image
    /// - Parameter state: state
    open func setImage(_ image: UIImage?, forState state: UIControl.State) {
        
        setTitle(nil, forState: state)
        fab.setImage(image, for: state)
        fab.adjustsImageWhenHighlighted = false
        fab.contentEdgeInsets = UIEdgeInsets.zero
    }
    
    /// Sets the position of fab relative to bottom/right on screen
    /// - Parameter bottom: distance from bottom of screen
    /// - Parameter trailing: distance from trailing of screen
    open func setPosition(bottom: CGFloat, trailing: CGFloat) {
        
        self.bottom = -bottom
        self.trailing = -trailing
        
        let safeGuide = parentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            fab.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: self.bottom),
            fab.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: self.trailing)
        ])
    }
    
    /// Shows or hides all the ActionButton's actions
    open func toggleMenu() {
        addButtonItems()
        toggle()
    }
    
    /// Method that is launched when the button is pressed
    /// - Parameter sender: UIControl
    @objc func buttonTapped(_ sender: UIControl) {
        
        animatePressingWith(scale: SCALE_TAPPED)
        
        guard let action = action else { return }
        action(self)
    }
    
    /// Method that is launched when the button is touch down
    /// - Parameter sender: UIControl
    @objc func buttonTouchDown(_ sender: UIButton) {
        animatePressingWith(scale: SCALE_TOUCHDOWN)
    }
    
    /// /// Method that is launched when tapped in background
    /// - Parameter gesture: UIGestureRecognizer
    @objc func backgroundTapped(_ gesture: UIGestureRecognizer) {
        if active {
            toggle()
        }
    }
    
    
    //MARK - Private Methods
    
    /// Setup View
    fileprivate func setupView() {
        
        // setup FAB
        setupFAB()
        
        // setup View
        setupContentView()
        
        // setup constraints
        setupConstraints()
    }
    
    /// Setup the FAB
    fileprivate func setupFAB() {
        
        fab = UIButton(type: .custom)
        fab.layer.cornerRadius = BUTTON_RADIUS / 2
        fab.layer.shadowOpacity = FAB_SHADOW_OPACITY
        fab.layer.shadowRadius = FAB_SHADOW_RADIUS
        fab.layer.shadowOffset = FAB_SHADOW_OFFSET
        fab.layer.shadowColor = FAB_SHADOW_COLOR
        fab.setTitle("+", for: UIControl.State())
        fab.backgroundColor = backgroundColor
        
        setFont(nil)
        
        fab.isUserInteractionEnabled = true
        fab.translatesAutoresizingMaskIntoConstraints = false
        
        fab.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        fab.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        
        parentView.addSubview(fab)
    }
    
    /// Setup ContentView
    fileprivate func setupContentView() {
        
        contentView = UIView(frame: parentView.bounds)
        
        blurVisualEffect = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blurVisualEffect.frame = contentView.frame
        
        contentView.addSubview(blurVisualEffect)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    /// Install all the necessary constraints for the button regarding to parentView, by default is 16x16
    fileprivate func setupConstraints() {
        
        let safeGuide = parentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            fab.widthAnchor.constraint(equalToConstant: BUTTON_RADIUS),
            fab.heightAnchor.constraint(equalToConstant: BUTTON_RADIUS),
            fab.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: bottom),
            fab.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: trailing)
        ])
    }
    
    /// Defines the position of all items
    fileprivate func addButtonItems() {
        
        guard let items = items else { return }
        
        for tmp in items {
            tmp.view.center = CGPoint(x: fab.center.x + ITEM_OFFSET_X, y: fab.center.y)
            tmp.view.removeFromSuperview()
            
            contentView.addSubview(tmp.view)
        }
    }
    
    /// Method that toogle the state of menu
    fileprivate func toggle() {
        
        animateMenu()
        showBlur()
        
        active = !active
        fab.backgroundColor = active ? backgroundColorSelected : backgroundColor
        fab.isSelected = active
    }
    
    /// Animate the button menu
    fileprivate func animateMenu() {
        
        let rotation = active ? 0 : CGFloat(Double.pi/4)
        
        UIView.animate(withDuration: TimeInterval(ANIMATION_DURATION), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .allowAnimatedContent, animations: { [weak self] in
            
            if self?.fab.imageView?.image == nil {
                self?.fab.transform = CGAffineTransform(rotationAngle: rotation)
            }
            
            self?.show(active: false)
            }, completion: { [weak self] completed in
                if self?.active == false {
                    self?.hideBlur()
                }
        })
    }
    
    /// Method that show the elements if the active variable is true, otherwhise hide
    /// - Parameter active: indicates if the elements should be displayed
    fileprivate func show(active: Bool) {
        
        if self.active == active {
            
            contentView.alpha = 1.0
            
            guard let items = items else { return }
            
            for (index, tmp) in items.enumerated() {
                let offset = index + 1
                let translation = ITEM_OFFSET_Y * CGFloat(offset)
                tmp.view.transform = CGAffineTransform(translationX: 0, y: CGFloat(translation))
                tmp.view.alpha = 1
            }
            
        } else {
            
            contentView.alpha = 0.0
            
            guard let items = items else { return }
            
            for item in items {
                item.view.transform = CGAffineTransform(translationX: 0, y: 0)
                item.view.alpha = 0
            }
        }
    }
    
    /// Show blur
    fileprivate func showBlur() {
        parentView.insertSubview(contentView, belowSubview: fab)
    }
    
    /// Hide blue
    fileprivate func hideBlur() {
        contentView.removeFromSuperview()
    }
    
    /// Animates the button pressing, by the default this method just scales the button down when it's pressed and returns to its normal size when the button is no longer pressed
    ///
    /// - Parameter scale: size button should be scaled
    fileprivate func animatePressingWith(scale: CGFloat) {
        
        UIView.animate(withDuration: TimeInterval(ANIMATION_DURATION), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .allowAnimatedContent, animations: { [weak self] in
            self?.fab.transform = CGAffineTransform(scaleX: scale, y: scale)
            }, completion: nil)
    }
}

