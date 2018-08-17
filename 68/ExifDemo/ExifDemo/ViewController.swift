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

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = Bundle.main.url(forResource: "IMG_3345", withExtension: "JPG")! as CFURL

        
        let imageSource = CGImageSourceCreateWithURL(url, nil)

//        let imageSource = CGImageSourceCreateWithData(UIImageJPEGRepresentation(imageView.image!, 1) as! CFData, nil)
        
        let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource!, 0, nil) as Dictionary?
        
        let exifDict = imageProperties?[kCGImagePropertyExifDictionary]
        
        let dateTimeOriginal = exifDict?[kCGImagePropertyExifDateTimeOriginal]
        
        let gps = imageProperties?[kCGImagePropertyGPSDictionary]
        let TIFF = imageProperties?[kCGImagePropertyTIFFDictionary]!
        let GIF = imageProperties?[kCGImagePropertyGIFDictionary]
        let ExifAux = imageProperties?[kCGImagePropertyExifAuxDictionary]
        let Raw = imageProperties?[kCGImagePropertyRawDictionary]
        let PNG = imageProperties?[kCGImagePropertyPNGDictionary]
        let JFIF = imageProperties?[kCGImagePropertyJFIFDictionary]
        
        let fileSize = imageProperties?[kCGImagePropertyFileSize]
        
        print("exifDict:",exifDict)
        print("ExifAux", ExifAux)
        print("gps", gps)
        print("TIFF:", TIFF)
        print("GIF:", GIF)
        print("ExifAux:", ExifAux)
        print("Raw:", Raw)
        print("JFIF:", JFIF)
        print("PNG", PNG)
        print("fileSize", fileSize)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

