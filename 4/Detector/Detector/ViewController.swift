//
//  ViewController.swift
//  Detector
//
//  Created by andyron on 2017/3/15.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var personPic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personPic.image = UIImage(named: "face-1")
        
        detect()
    }

    func detect() {
        guard let personciImage = CIImage(image: personPic.image!) else {
            return
        }
        // 精确度
        let accuray = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetetor = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuray)
        let faces = faceDetetor?.features(in: personciImage)
        // 从Core Image的坐标系转换为UIView的坐标系
        let ciImageSize = personciImage.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        for face in faces as! [CIFaceFeature] {
            print("Found bounds are \(face.bounds)")
            
            var faceViewBounds = face.bounds.applying(transform)
            // 计算在image view中位置
            let viewSize = personPic.bounds.size
            let scale = min(viewSize.width/ciImageSize.width, viewSize.height/ciImageSize.height)
            let offsetX = (viewSize.width - ciImageSize.width*scale) / 2
            let offsetY = (viewSize.height - ciImageSize.height*scale) / 2
            
            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY
            
            let faceBox = UIView(frame: faceViewBounds)
            
            
            faceBox.layer.borderWidth = 3
            faceBox.layer.borderColor = UIColor.red.cgColor
            faceBox.backgroundColor = UIColor.clear
            personPic.addSubview(faceBox)
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        }
    }


}

