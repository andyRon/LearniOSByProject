//
//  scaleRotationViewController.swift
//  CABasic Animation
//
//  Created by andyron on 2017/9/4.
//  Copyright © 2017年 andyron. All rights reserved.
// 缩放和旋转

import UIKit

class ScaleRotationViewController: UIViewController {
    // 用于缩放的layer
    lazy var redLayer: CALayer = {
        return self.createLayer(position: CGPoint(x: 125, y: 150), backgroundColor: UIColor.red)
    }()
    
    lazy var greenLayer: CALayer = {
        return self.createLayer(position: CGPoint(x: 125, y: 250), backgroundColor: UIColor.green)
    }()
    
    lazy var cyanLayer: CALayer = {
        return self.createLayer(position: CGPoint(x: 125, y: 350), backgroundColor: UIColor.cyan)
    }()
    
    lazy var blueLayer: CALayer = {
        return self.createLayer(position: CGPoint(x: 125, y: 450), backgroundColor: UIColor.blue)
    }()
    
    // 用于旋转的Layer
    lazy var redRotationLayer: CALayer = {
        return self.createLayer(position: CGPoint(x: 300, y: 150), backgroundColor: UIColor.red)
    }()
    
    lazy var greenRotationLayer: CALayer = {
        return self.createLayer(position: CGPoint(x: 300, y: 250), backgroundColor: UIColor.green)
    }()
    
    lazy var cyanRotationLayer: CALayer = {
        return self.createLayer(position: CGPoint(x: 300, y: 350), backgroundColor: UIColor.cyan)
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加缩放的动画
        redLayer.add(createAnimation(keyPath: "transform.scale.x", toValue: 0.5), forKey: nil)
        
        greenLayer.add(createAnimation(keyPath: "transform.scale.y", toValue: 0.5), forKey: nil)
        
        cyanLayer.add(createAnimation(keyPath: "transform.scale.z", toValue: 0.5), forKey: nil)
        
        blueLayer.add(createAnimation(keyPath: "transform.scale", toValue: 0.5), forKey: nil)
        
        
        
        // 添加旋转的动画
        redRotationLayer.add(createAnimation(keyPath: "transform.rotation.x", toValue: CGFloat(Double.pi / 4)), forKey: nil)
        
        greenRotationLayer.add(createAnimation(keyPath: "transform.rotation.y", toValue: CGFloat(Double.pi / 4)), forKey: nil)
        
        cyanRotationLayer.add(createAnimation(keyPath: "transform.rotation.z", toValue: CGFloat(Double.pi / 4)), forKey: nil)
        
        
        self.creatLabel(title: "缩放", frame: CGRect(x: 100, y: 80, width: 50, height: 20))
        self.creatLabel(title: "旋转", frame: CGRect(x: 250, y: 80, width: 50, height: 20))
        self.creatLabel(title: "X轴", frame: CGRect(x: 20, y: 125, width: 50, height: 20))
        self.creatLabel(title: "Y轴", frame: CGRect(x: 20, y: 225, width: 50, height: 20))
        self.creatLabel(title: "Z轴", frame: CGRect(x: 20, y: 325, width: 50, height: 20))
        self.creatLabel(title: "XYZ轴", frame: CGRect(x: 20, y: 425, width: 50, height: 20))
    }


    // 创建calayer
    func createLayer (position: CGPoint, backgroundColor: UIColor) -> CALayer {
        //创建calayer
        let layer = CALayer()
        //设置位置和大小
        layer.position = position
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        //设置背景颜色
        layer.backgroundColor = backgroundColor.cgColor
        //把layer添加到UIView的layer上
        self.view.layer.addSublayer(layer)
        
        return layer
    }
    
    // 创建基础Animation
    func createAnimation (keyPath: String, toValue: CGFloat) -> CABasicAnimation {
        //创建动画对象
        let scaleAni = CABasicAnimation()
        //设置动画属性
        scaleAni.keyPath = keyPath
        
        //设置动画的起始位置。也就是动画从哪里到哪里。不指定起点，默认就从positoin开始
        scaleAni.toValue = toValue
        
        //动画持续时间
        scaleAni.duration = 2;
        
        //动画重复次数
        scaleAni.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        
        return scaleAni;
    }
    
    
    //创建Label
    fileprivate func creatLabel (title: String, frame: CGRect) -> (){
        let label = UILabel()
        
        label.text = title
        label.frame = frame
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        
        self.view.addSubview(label)
        
    }
}
