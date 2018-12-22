//
//  ViewController.swift
//  SwiftCoreImageTutorial
//
//  Created by andyron on 2017/3/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "dog.jpg")
        let originalImage = CIImage(image: image!)
        
        
        // https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346
        let filter = CIFilter(name: "CIPhotoEffectTonal")
        filter?.setDefaults()
        filter?.setValue(originalImage, forKey: kCIInputImageKey)
        
        
        let outputImage = filter?.outputImage
        let newImage = UIImage(ciImage: outputImage!)
        imageView.image = newImage
    
    }




}

