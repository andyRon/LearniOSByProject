//
//  ProductViewController.swift
//  GoodAsOldPhones
//
//  Created by Andy Ron on 2018/8/4.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productNameLabel.text = product?.name
        
        if let imageName = product?.fullscreenImageName {
            productImageView.image = UIImage(named: imageName)
        }
    }

    @IBAction func addToCartButtonDidTap(_ sender: UIButton) {
        print("Add to cart successfully")
    }
    

}
