//
//  ViewController.swift
//  MutipleThreadDemo
//
//  Created by andyron on 2017/8/22.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    let imgUrl = "http://andyron.com/images/avatar.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func dynamicCreateThread() {
        let thread = Thread.init(target: self, selector: #selector(ViewController.loadImageSoure(url:)), object: imgUrl)
        thread.threadPriority = 1
        thread.start()
    }
    
    func staticCreateThread() {
        Thread.detachNewThreadSelector(#selector(ViewController.loadImageSoure(url:)), toTarget: self, with: imgUrl)
    }
    
    func implicitCreateThread() {
        self.performSelector(inBackground: #selector(ViewController.loadImageSoure(url:)), with: imgUrl)
    }
    
    @objc func loadImageSoure(url: String) {
        let imageData = try? Data.init(contentsOf: URL(string: url)!)
        let image = UIImage(data: imageData!)!
        if imageData != nil {
            self.performSelector(onMainThread: #selector(ViewController.refreshImageView(image:)), with: image, waitUntilDone: true)
        } else {
            print("没有图片资源")
        }
    }
    
    @objc func refreshImageView(image: UIImage) {
        self.label.isHidden = true
        self.imageView.image = image
    }
    
    @IBAction func load(sender: UIButton) {
        self.imageView.image = nil
        self.label.isHidden = false
        
        switch sender.tag {
        case 1:
            self.dynamicCreateThread()
        case 2:
            self.staticCreateThread()
        case 3:
            self.implicitCreateThread()
        default:
            break;
        }
        
    }
}

