//
//  CustomCellViewController.swift
//  IDIAZM_Example
//
//  Created by Iván Díaz Molina on 07/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CustomCellViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: VARS AND LETS
    private var elements: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: private methods
    private func setupView() {
        
        self.title = "Custom Cell"
        
        for i in 0...5 {
            elements.append("Element \(i)")
        }
        
        tableView.register(CustomViewTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CustomCellViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomViewTableViewCell.identifier) as? CustomViewTableViewCell else { return UITableViewCell()}

        let element = elements.getElement(indexPath.row) ?? ""
        
        cell.titleLabel.text = "Title \(element)"
        cell.subtitleLabel.text = "Subtitle \(element)"
        
        return cell
    }
}
