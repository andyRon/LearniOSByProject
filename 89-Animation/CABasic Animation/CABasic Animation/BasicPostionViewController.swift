//
//  BasicPostionViewController.swift
//  CABasic Animation
//
//  Created by andyron on 2017/9/4.
//  Copyright © 2017年 andyron. All rights reserved.
// 基础平移

import UIKit

class BasicPostionViewController: UIViewController, CAAnimationDelegate {

    lazy var redLayer: CALayer = {
        return self.createLayer()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        redLayer = createLayer()
        view.layer.addSublayer(redLayer)
        
        let basicAni = createCABasicAnimation()
        self.redLayer.add(basicAni, forKey: "basicPosition")    // forKey 是动画对象的名字
    }
    
    func createLayer() -> CALayer {
        let redLayer = CALayer()
        
        redLayer.position = CGPoint(x: 200, y: 200)
        redLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        redLayer.backgroundColor = UIColor.red.cgColor
        return redLayer
    }
    
    func createCABasicAnimation() -> CABasicAnimation {
        let basicAni = CABasicAnimation()
        // 设置动画属性
        basicAni.keyPath = "position"
        
        basicAni.fromValue = NSValue.init(cgPoint: CGPoint(x: 0, y: 0))
        
        basicAni.toValue = NSValue.init(cgPoint: CGPoint(x: 300, y: 300))
        
        basicAni.duration = 2
        
        basicAni.fillMode = kCAFillModeForwards
        
        basicAni.isRemovedOnCompletion = false
        
        basicAni.delegate = self
        
        return basicAni
    }

    // MARK: - CAAnimationDelegate
    func animationDidStart(_ anim: CAAnimation) {
        self.redLayer.position = CGPoint(x: 300, y: 300)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.redLayer.position = CGPoint(x: 300, y: 400)
        
        self.redLayer.removeAnimation(forKey: "basicPosition")
        
    }

}
