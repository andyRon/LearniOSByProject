//
//  InspirationsViewController.swift
//  Ultravisual
//
//  Created by Andy Ron on 2018/11/6.
//  Copyright © 2018 Andy Ron. All rights reserved.
//

import UIKit

class InspirationsViewController: UICollectionViewController {
    
    let inspirations = Inspiration.allInspirations()
    let colors = UIColor.palette()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(InspirationCell.self, forCellWithReuseIdentifier: InspirationCell.reuseIdentifier)
        
        
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        collectionView?.backgroundColor = .clear
        
//        let layout = collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: collectionView!.bounds.width, height: 100)

    }

}

extension InspirationsViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inspirations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InspirationCell.reuseIdentifier, for: indexPath) as? InspirationCell else {
            return UICollectionViewCell()
        }
        
        cell.contentView.backgroundColor = colors[indexPath.item]
//        cell.inspiration = inspirations[indexPath.item]
        return cell
    }
}
