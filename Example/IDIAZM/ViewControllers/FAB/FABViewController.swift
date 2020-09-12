//
//  FABViewController.swift
//  IDIAZM_Example
//
//  Created by Iván Díaz Molina on 11/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class FABViewController: UIViewController {
    
    var fab : FAB!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
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
        fab.setTitle("+", forState: UIControl.State())
//        fab.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 130.0/255.0, alpha: 1)
        fab.action = { button in
            button.toggleMenu()
        }
    }
}
