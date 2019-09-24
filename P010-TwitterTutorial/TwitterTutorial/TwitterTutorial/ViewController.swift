//
//  ViewController.swift
//  TwitterTutorial
//
//  Created by andyron on 2017/3/24.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  @IBOutlet weak var imageView: UIImageView!
  
  var pickerController: UIImagePickerController  = UIImagePickerController()
  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func chooseImagePressed(_ sender: UIButton) {
      
    pickerController.delegate = self
    pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
      
    present(pickerController, animated: true, completion: nil)
  }


  @IBAction func tweetButtonPressed(_ sender: UIButton) {
    
    // 不翻墙，会导致失效
    if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
        
      if let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
          
        tweetSheet.setInitialText("看着漂亮的图片了")
        tweetSheet.add(imageView.image)
        
        present(tweetSheet, animated: true, completion: nil)
      }
    } else {
      print("error")
    }
  }
  //MARK: - UIImagePickerControllerDelegate
  // 获取图片后调用
  private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    imageView.image = info.index(forKey: UIImagePickerController.InfoKey.originalImage.rawValue) as? UIImage
    
    dismiss(animated: true, completion: nil)
  }
}

