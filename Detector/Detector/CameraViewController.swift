//
//  CameraViewController.swift
//  Detector
//
//  Created by andyron on 2017/3/15.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    //MARK: -UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
        self.detect()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func detect() {
        let imageOptions = NSDictionary(object: NSNumber(value: 5) as NSNumber, forKey: CIDetectorImageOrientation as NSString)
        let personciImage = CIImage(cgImage: imageView.image!.cgImage!)
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage, options: imageOptions as? [String : AnyObject])
        
        if let face = faces?.first as? CIFaceFeature {
            print("found bounds are \(face.bounds)")
            
            var message = "有个脸"
            
            if face.hasSmile {
                print("脸是笑的")
                message += ",脸是笑的"
            }
            if face.hasMouthPosition {
                print("有嘴唇")
                message += ",有嘴唇"
            }
            
            if face.hasLeftEyePosition {
                print("左眼镜的位置是 \(face.leftEyePosition)")
                message += ",左眼镜的位置是 \(face.leftEyePosition)"
            }
            
            if face.hasRightEyePosition {
                print("右眼镜的位置是 \(face.rightEyePosition)")
                message += ",右眼镜的位置是 \(face.rightEyePosition)"
            }
            
            let alert = UIAlertController(title: "嘿嘿", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "没脸了", message: "没有检测到脸", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}
