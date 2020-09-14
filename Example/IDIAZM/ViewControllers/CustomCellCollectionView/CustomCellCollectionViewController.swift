//
//  CustomCellCollectionViewController.swift
//  IDIAZM_Example
//
//  Created by Iván Díaz Molina on 14/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CustomCellCollectionViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: VARS AND LETS
    private var elements: [String] = []
    private let ITEMS_BY_ROW: CGFloat = 5
    private let SECTION_INSETS = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    fileprivate func setupView() {
        
        self.title = "Custom Cell CollectionView"
        
        for i in 0...19 {
            elements.append("Element \(i)")
        }
        
        collectionView.register(CustomViewCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension CustomCellCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomViewCollectionViewCell.identifier, for: indexPath) as? CustomViewCollectionViewCell else { return UICollectionViewCell()}
        
        cell.titleLabel.text = "\(indexPath.row)"
        cell.titleLabel.textColor = .white
        cell.backgroundColor = UIColor.random()
        
        return cell
    }
}

// MARK: UICollectionViewFlowLayout
extension CustomCellCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // get the padding space between items
        let padding = SECTION_INSETS.left * (ITEMS_BY_ROW + 1)
        
        // get the available width of the screen
        let availableWidth = view.frame.width - padding
        
        // calculate the width of the item
        let itemWidth = availableWidth / ITEMS_BY_ROW
        
        // return item size
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return SECTION_INSETS
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return SECTION_INSETS.left
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
