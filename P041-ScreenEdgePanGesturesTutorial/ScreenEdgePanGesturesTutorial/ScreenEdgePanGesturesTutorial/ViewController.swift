//
//  ViewController.swift
//  ScreenEdgePanGesturesTutorial
//
//  Created by andyron on 2017/3/30.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        screenEgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(ViewController.rotateBall(sender:)))
        screenEgeRecognizer.edges = .left
        view.addGestureRecognizer(screenEgeRecognizer)
    }



    @IBOutlet var imageView: UIImageView!
    
    var screenEgeRecognizer: UIScreenEdgePanGestureRecognizer!
    var currentRadius: CGFloat = 0.0
    
    
    func rotateBall(sender: UIScreenEdgePanGestureRecognizer) {
        
        if sender.state == .ended {
            
            if self.currentRadius == 360.0 {
                self.currentRadius = 0.0
            }
            
            UIView.animate(withDuration: 1.0, animations: {
                self.currentRadius += 90.0
                self.imageView.transform = CGAffineTransform(rotationAngle: (self.currentRadius * CGFloat(M_PI)) / 180.0)
                
            })
        }
    }
    

}

