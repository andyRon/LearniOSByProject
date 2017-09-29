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
        

        
        let url = Bundle.main.url(forResource: "IMG_0845", withExtension: "jpg") as! CFURL
//        let url = NSURL(string: "http://jwphotographic.co.uk/Images/1.jpg")
        let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil)
        let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource!, 0, nil) as Dictionary?
        let exifDict = imageProperties?[kCGImagePropertyExifDictionary]
        
        let dateTimeOriginal = exifDict?[kCGImagePropertyExifDateTimeOriginal]
        
        let gps = imageProperties?[kCGImagePropertyGPSDictionary]!
        let TIFF = imageProperties?[kCGImagePropertyTIFFDictionary]!
        let GIF = imageProperties?[kCGImagePropertyGIFDictionary]
        let ExifAux = imageProperties?[kCGImagePropertyExifAuxDictionary]
        let Raw = imageProperties?[kCGImagePropertyRawDictionary]
        let PNG = imageProperties?[kCGImagePropertyPNGDictionary]
        let JFIF = imageProperties?[kCGImagePropertyJFIFDictionary]!
        
        print(exifDict,gps)
        print("TIFF:", TIFF)
        print("GIF:", GIF)
        print("ExifAux:", ExifAux)
        print("Raw:", Raw)
        print("JFIF:", JFIF)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

