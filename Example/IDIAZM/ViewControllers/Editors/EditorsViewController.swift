//
//  EditorsViewController.swift
//  IDIAZM_Example
//
//  Created by David Manuel Fernández Suárez on 01/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class EditorsViewController: UIViewController {
    

    @IBOutlet weak var stack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        /// Add Checkbox component
        addCheckbox()
    }
    
    private func addCheckbox() {
        let check = Checkbox()
        check.updateUI(on: true, text: "Checkbox")
        stack.addArrangedSubview(check)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

