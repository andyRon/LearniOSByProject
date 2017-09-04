//
//  BasicPostion2ViewController.swift
//  CABasic Animation
//
//  Created by andyron on 2017/9/4.
//  Copyright © 2017年 andyron. All rights reserved.
// 基础平移2

import UIKit

class BasicPostion2ViewController: UIViewController, CAAnimationDelegate{

    lazy var redLayer: CALayer = {
        return self.createLayer(postion: CGPoint(x: 0, y: 150), backgroundColor: UIColor.red)
    }()
    
    lazy var greenLayer: CALayer = {
        return self.createLayer(postion: CGPoint(x: 0, y: 250), backgroundColor: UIColor.green)
    }()
    
    lazy var cyanLayer: CALayer = {
        return self.createLayer(postion: CGPoint(x: 0, y: 350), backgroundColor: UIColor.cyan)
    }()
    
    lazy var blueLayer: CALayer = {
        return self.createLayer(postion: CGPoint(x: 0, y: 450), backgroundColor: UIColor.blue)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redLayer.add(createBasicAnimation(fromValue: CGPoint(x: 0, y: 150), toValue: CGPoint(x: 300, y: 150), timingFunction: kCAMediaTimingFunctionLinear), forKey: "basicAnimation")
        view.layer.addSublayer(redLayer)
        
        greenLayer.add(createBasicAnimation(fromValue: CGPoint(x: 0, y: 250), toValue: CGPoint(x: 300, y: 250), timingFunction: kCAMediaTimingFunctionEaseIn), forKey: "basicAnimation")
        view.layer.addSublayer(greenLayer)
        
        cyanLayer.add(createBasicAnimation(fromValue: CGPoint(x: 0, y: 350), toValue: CGPoint(x: 300, y: 350), timingFunction: kCAMediaTimingFunctionEaseOut), forKey: "basicAnimation")
        view.layer.addSublayer(cyanLayer)
        
        blueLayer.add(createBasicAnimation(fromValue: CGPoint(x: 0, y: 450), toValue: CGPoint(x: 300, y: 450), timingFunction: kCAMediaTimingFunctionEaseInEaseOut), forKey: "basicAnimation")
        view.layer.addSublayer(blueLayer)
        

    }

    func createLayer(postion: CGPoint, backgroundColor: UIColor) -> CALayer {
        let layer = CALayer()
        layer.position = postion
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.backgroundColor = backgroundColor.cgColor
        return layer
    }
    
    func createBasicAnimation (fromValue: CGPoint, toValue: CGPoint, timingFunction: String) -> CABasicAnimation {
        let basicAni = CABasicAnimation()
        
        basicAni.keyPath = "position"
        
        basicAni.fromValue = fromValue
        
        basicAni.toValue = toValue
        
        basicAni.duration = 2
        
//        basicAni.fillMode = kCAFillModeForwards
        
//        basicAni.isRemovedOnCompletion = false
        
        basicAni.timingFunction = CAMediaTimingFunction(name: timingFunction)
        
        basicAni.delegate = self
        
        
        
        return basicAni
        
    }

}
