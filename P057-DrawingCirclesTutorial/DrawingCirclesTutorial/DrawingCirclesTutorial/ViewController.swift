//
//  ViewController.swift
//  DrawingCirclesTutorial
//
//  Created by andyron on 2017/4/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGray
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if let touch = touches as? Set<UITouch> {
            
            let circleCenter = touch.first!.location(in: view)
            
            
            let circleWidth = CGFloat(25 + (arc4random() % 50))
            let circleHeight = circleWidth
            
            print(circleCenter, circleWidth, circleHeight)
            let circleView = CircleView(frame: CGRect(x: circleCenter.x, y: circleCenter.y, width: circleWidth, height: circleHeight))
            self.view.addSubview(circleView)
        }
    }


}

