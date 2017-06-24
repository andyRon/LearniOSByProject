//
//  ViewController.swift
//  LottieDemo
//
//  Created by andyron on 2017/6/24.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import Lottie


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let animationView = LOTAnimationView(name: "like") {
//            animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//            animationView.center = self.view.center
//            animationView.contentMode = .scaleAspectFill
//            
//            animationView.loopAnimation = true
//            animationView.animationSpeed = 1
//            
//            view.addSubview(animationView)
//            
//            animationView.play()
//        }
        
        if let animationView = LOTAnimationView(contentsOf: URL(string: "https://github.com/airbnb/lottie-ios/raw/master/Example/Assets/PinJump.json")!) {
            animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            animationView.center = self.view.center
            animationView.contentMode = .scaleAspectFill
            
            animationView.loopAnimation = true
            //动画播放速度，越大越快
            animationView.animationSpeed = 1
            
//            animationView.transform = CGAffineTransform(rotationAngle: -45.0)
            
            animationView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 3.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
                animationView.transform = CGAffineTransform.identity
            }, completion: nil)

            view.addSubview(animationView)
            
            animationView.play()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

