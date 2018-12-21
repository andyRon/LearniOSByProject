//
//  InspirationCell.swift
//  Ultravisual
//
//  Created by Andy Ron on 2018/11/6.
//  Copyright © 2018 Andy Ron. All rights reserved.
//

import UIKit

class InspirationCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: InspirationCell.self)
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var inspiration: Inspiration? {
        didSet {
            if let inspiration = inspiration {
                imageView.image = inspiration.backgroundImage
            }
        }
    }
}
