//
//  IntrinsicHeightTableViewViewController.swift
//  IDIAZM_Example
//
//  Created by Iván Díaz Molina on 06/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class IntrinsicHeightTableViewViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var intrinsicHeightTableView: UITableView!
    @IBOutlet weak var removeButton: UIButton!
    
    // MARK: VARS AND LETS
    private var elements: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: private methods
    private func setupView() {
        
        self.title = "Intrinsic Height TableView"
        
        intrinsicHeightTableView.delegate = self
        intrinsicHeightTableView.dataSource = self
        
        for i in 0...5 {
            elements.append("Element \(i)")
        }
    }
    
    private func reloadData() {
        intrinsicHeightTableView.reloadData()
    }

    // MARK: IBAction
    @IBAction func onTapAddButton(_ sender: UIButton) {
        print("onTapAddButton")
        
        elements.append("Element \(elements.count)")
        
        removeButton.isEnabled = true
        
        reloadData()
    }
    
    @IBAction func onTapRemoveButton(_ sender: UIButton) {
        print("onTapRemoveButton")
        
        elements.removeLast()
        
        reloadData()
        
        removeButton.isEnabled = !elements.isEmpty
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension IntrinsicHeightTableViewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell()}

        cell.textLabel?.text = elements.getElement(indexPath.row)
        
        return cell
    }
}
