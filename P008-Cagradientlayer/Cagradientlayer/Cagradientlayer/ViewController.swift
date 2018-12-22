//
//  ViewController.swift
//  Cagradientlayer
//
//  Created by andyron on 2017/3/17.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    var gradientLayer: CAGradientLayer!
    
    var colorSets = [[CGColor]]()
    var currentColorSet: Int!
    
    var panDirection: PanDirections!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createColorSets()
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTapGesture(gestureRecognizer:)))
//        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        let twoFingerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTwoFingerTapGesture(gestureRecognizer:)))
        twoFingerTapGestureRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(twoFingerTapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanGestureRecognizer(gestureRecognizer:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradientLayer()
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = colorSets[currentColorSet]
        
        // gradient 的占比
        gradientLayer.locations = [0, 0.35]
//         gradientLayer.locations = [0.5, 0.35]  // ??
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.view.layer.addSublayer(gradientLayer)
    }

    func createColorSets() {
        colorSets.append([UIColor.red.cgColor, UIColor.yellow.cgColor])
        colorSets.append([UIColor.green.cgColor, UIColor.magenta.cgColor])
        colorSets.append([UIColor.gray.cgColor, UIColor.lightGray.cgColor])
        
        currentColorSet = 0
    }
    
    func handleTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        if currentColorSet < colorSets.count - 1 {
            currentColorSet! += 1
        } else {
            currentColorSet = 0
        }
        
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.duration = 2.0
        colorChangeAnimation.toValue = colorSets[currentColorSet]
        colorChangeAnimation.fillMode = kCAFillModeForwards
        colorChangeAnimation.isRemovedOnCompletion = false
        
        colorChangeAnimation.delegate = self
        
        gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
    }
    
    func handleTwoFingerTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        let secondColorLocation = arc4random_uniform(100)
        let firstColorLocation = arc4random_uniform(secondColorLocation - 1)
        
        gradientLayer.locations = [NSNumber(value: Double(firstColorLocation)/100.0), NSNumber(value: Double(secondColorLocation)/100.0)]
        
        print(gradientLayer.locations!)
    }
    
    func handlePanGestureRecognizer(gestureRecognizer: UIPanGestureRecognizer) {
        let velocity = gestureRecognizer.velocity(in: self.view)
        
        // 通过x轴和y轴上的速度来判断方向
        if gestureRecognizer.state == UIGestureRecognizerState.changed {
            if velocity.x > 300.0 {
                
                if velocity.y > 300.0 {
                    panDirection = PanDirections.TopLeftToBottomRight
                } else if velocity.y  < -300.0 {
                    panDirection = PanDirections.BottomLeftToTopRight
                } else {
                    panDirection = PanDirections.Right
                }
            } else if velocity.x < -300.0 {
                
                if velocity.y > 300.0 {
                    panDirection = PanDirections.TopRightToBottomLeft
                } else if velocity.y < -300.0 {
                    panDirection = PanDirections.BottomRightToTopLeft
                } else {
                    panDirection = PanDirections.Left
                }
            } else {
                
                if velocity.y > 300.0 {
                    panDirection = PanDirections.Bottom
                } else if velocity.y < -300.0 {
                    panDirection = PanDirections.Top
                } else {
                    panDirection = nil
                }
            }
        } else if gestureRecognizer.state == UIGestureRecognizerState.ended {
            changeGradientDirection()
        }
    }
    
    func changeGradientDirection() {
        if panDirection != nil {
            switch panDirection.rawValue {
            case PanDirections.Right.rawValue:
                gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
                gradientLayer.endPoint = CGPoint(x:1.0, y:0.5)
            case PanDirections.Left.rawValue:
                gradientLayer.startPoint = CGPoint(x:1.0, y:0.5)
                gradientLayer.endPoint = CGPoint(x:0.0, y:0.5)
            case PanDirections.Top.rawValue:
                gradientLayer.startPoint = CGPoint(x:0.5, y:1.0)
                gradientLayer.endPoint = CGPoint(x:0.5, y:0.0)
            case PanDirections.Bottom.rawValue:
                gradientLayer.startPoint = CGPoint(x:0.5, y:0.0)
                gradientLayer.endPoint = CGPoint(x:0.5, y:1.0)
            case PanDirections.TopLeftToBottomRight.rawValue:
                gradientLayer.startPoint = CGPoint(x:0.0, y:0.0)
                gradientLayer.endPoint = CGPoint(x:1.0, y:1.0)
            case PanDirections.TopRightToBottomLeft.rawValue:
                gradientLayer.startPoint = CGPoint(x:1.0, y:0.0)
                gradientLayer.endPoint = CGPoint(x:0.0, y:1.5)
            case PanDirections.BottomLeftToTopRight.rawValue:
                gradientLayer.startPoint = CGPoint(x:0.0, y:1.0)
                gradientLayer.endPoint = CGPoint(x:1.0, y:0.0)
                
//            case PanDirections.BottomRightToTopLeft.rawValue:
            default:
                gradientLayer.startPoint = CGPoint(x:1.0, y:1.0)
                gradientLayer.endPoint = CGPoint(x:0.0, y:0.0)
            
            }
        }
    }
    
    //MARK: - CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradientLayer.colors = colorSets[currentColorSet]
        }
    }
}

