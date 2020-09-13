//
//  FABViewController.swift
//  IDIAZM_Example
//
//  Created by Iván Díaz Molina on 11/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FABViewController: UITabBarController {
    
    // MARK: IBOutlets

    // MARK: VARS AND LETS
    var fab : FAB!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    /// setup view
    func setupView() {
        
        let facebook = FABItem(title: "Facebook", image: UIImage(named: "facebook_round"))
        facebook.action = { item in
            print("Facebook tapped")
        }
        
        let twitter = FABItem(title: "Twitter", image: UIImage(named: "twitter_round"))
        twitter.action = { item in
            print("Twitter tapped")
        }
        
        fab = FAB(attachedToView: self.view, items: [facebook, twitter])
//        fab = FAB(attachedToView: self.view, items: [facebook, twitter], bottom: 50, trailing: 50)
        fab.setTitle("+", forState: UIControl.State())
        fab.action = { button in
            button.toggleMenu()
        }
        
//        fab.setPosition(bottom: fab.bottom, trailing: 100)
    }
}
