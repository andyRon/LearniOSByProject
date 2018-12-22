//
//  ViewController.swift
//  GestureDemo
//
//  Created by andyron on 2017/8/22.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    
    var isChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(tap:)))
        tap.numberOfTapsRequired = 2
//        tap.numberOfTouchesRequired = 2  // 点击手指数目
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(pan:)))
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinch(pinch:)))
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotation(rotation:)))
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipe(swipe:)))
        swipe.direction = .up
        swipe.numberOfTouchesRequired = 3
        
        let long = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.long(long:)))
        long.numberOfTouchesRequired = 2
        long.minimumPressDuration = 1
        
        let screenEdge = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(ViewController.screenEdage(screenEdage:)))
        screenEdge.edges = .left
        
        imageView.isUserInteractionEnabled = true  // 开启交互
        imageView.addGestureRecognizer(tap)
        imageView.addGestureRecognizer(pan)
        imageView.addGestureRecognizer(pinch)
        imageView.addGestureRecognizer(rotation)
        view.addGestureRecognizer(swipe)
        imageView.addGestureRecognizer(long)
        view.addGestureRecognizer(screenEdge)
    }
    
    @objc func tap(tap: UITapGestureRecognizer) {
        let center = imageView.center
        if isChange {
            imageView.frame.size.width /= 2
            imageView.frame.size.height /= 2
            imageView.center = center
            isChange = false
        } else {
            imageView.frame.size.width *= 2
            imageView.frame.size.height *= 2
            imageView.center = center
            isChange = true
        }
    }
    
    @objc func pan(pan: UIPanGestureRecognizer) {
        if pan.state == .began || pan.state == .changed {
            // 移动后的变化（变化值类似向量）
            let translation = pan.translation(in: imageView.superview)
            print(translation)
            imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y  + translation.y)
            // view移动后，把上一步的移动值变为0，否则移动值为递增
            pan.setTranslation(CGPoint.zero, in: imageView.superview)
        }
    }
    
    @objc func pinch(pinch: UIPinchGestureRecognizer) {
        if pinch.state == .began || pinch.state == .changed {
            imageView.transform = CGAffineTransform(scaleX: pinch.scale, y: pinch.scale)
        }
    }
    
    @objc func rotation(rotation: UIRotationGestureRecognizer) {
        if rotation.state == .began || rotation.state == .changed {
            imageView.transform = CGAffineTransform(rotationAngle: rotation.rotation)
        }
    }
    
    @objc func swipe(swipe: UISwipeGestureRecognizer) {
        print("扫的方向：\(swipe.direction),扫的手指数：\(swipe.numberOfTouchesRequired)")
    }
    
    @objc func long(long: UILongPressGestureRecognizer) {
        print("长按手势，长按字头数为\(long.numberOfTouchesRequired)")
    }
    
    @objc func screenEdage(screenEdage: UIScreenEdgePanGestureRecognizer) {
        print("屏幕边缘滑动手势：\(screenEdage.edges)")
    }
    

}

