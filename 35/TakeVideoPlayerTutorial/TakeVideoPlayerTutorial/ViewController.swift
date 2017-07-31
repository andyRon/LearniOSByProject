//
//  ViewController.swift
//  TakeVideoPlayerTutorial
//
//  Created by andyron on 2017/3/28.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary  // iOS 9后不用
import Photos


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var controller = UIImagePickerController()
     var assetsLibrary = ALAssetsLibrary()
    
    var photos = PHAsset()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func takeVideo(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            controller.sourceType = .camera
            controller.mediaTypes = [kUTTypeMovie as String]
            controller.delegate = self
            controller.videoMaximumDuration = 10.0
            
            present(controller, animated: true, completion: nil)
            
        } else {
            print("Camera is not available")
        }
    }

    
    @IBAction func viewLibrary(_ sender: AnyObject) {
        
        controller.sourceType = .photoLibrary
        controller.mediaTypes = [kUTTypeMovie as String]
        controller.delegate = self
        
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType]
        
        if let type = mediaType {
            if type is String {
                let stringType = type as! String
                if stringType == kUTTypeMovie as String {
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? URL
                    if let url = urlOfVideo {
                        // photos的使用
                        
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

