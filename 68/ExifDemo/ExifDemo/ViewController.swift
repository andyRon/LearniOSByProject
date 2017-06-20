//
//  ViewController.swift
//  ExifDemo
//
//  Created by andyron on 2017/6/20.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import ImageIO
import CoreFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let fileUrl = Bundle.main.url(forResource: "IMG_0845", withExtension: "jpg")
//        let imageData = fileUrl?.dataRepresentation
        
//        let image = UIImage(named: <#T##String#>)
//        let imageData = UIImageJPEGRepresentation(UIImage(named: "IMG_0845")!, 1)
//        let source = CGImageSourceCreateWithData(imageData! as CFData, nil)
//        let imageInfo = CGImageSourceCopyPropertiesAtIndex(source!, 0, nil)
        
        
        let url = NSURL(string: "https://i.stack.imgur.com/jYGF4.png")
        let imageSource = CGImageSourceCreateWithURL(url!, nil)
        let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource!, 0, nil) as Dictionary?
        let exifDict = imageProperties?[kCGImagePropertyExifDictionary]
        
        
        let dateTimeOriginal = exifDict?[kCGImagePropertyExifDateTimeOriginal]
        print("dateTimeOriginal: \(dateTimeOriginal)")
//        print(exifDict)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

