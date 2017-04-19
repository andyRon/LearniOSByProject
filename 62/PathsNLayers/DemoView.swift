//
//  DemoView.swift
//  PathsNLayers
//
//  Created by andyron on 2017/4/19.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

// 没一个角度度数的弧度值
let radian: CGFloat = CGFloat(M_PI / 180.0)

class DemoView: UIView {

    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
        
        simpleShapeLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        //        self.createRectangle()
        //        self.createTriangle()
        
        // 椭圆
        //        self.path = UIBezierPath(ovalIn: self.bounds)
        //圆
        //        self.path = UIBezierPath(ovalIn: CGRect(x: self.frame.size.width/2-self.frame.size.height/2, y: 0.0, width: self.frame.size.height, height: self.frame.size.height))
        
        // 圆形角
        //        path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 15.0)
        // 部分圆形角
        //        path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 15.0, height: 0.0))
        // 圆弧 半圆
        //        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
        //                            radius: self.frame.size.height/2,
        //                            startAngle: CGFloat(M_PI),
        //                            endAngle: 0.0,
        //                            clockwise: true)
        //        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
        //                            radius: self.frame.size.height/2,
        //                            startAngle: CGFloat(3*M_PI/2),
        //                            endAngle: CGFloat(M_PI/2),
        //                            clockwise: false)
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
                            radius: self.frame.size.height/2,
                            startAngle: radian * 240.0,
                            endAngle: radian * 15.0,
                            clockwise: false)
        
        
        UIColor.orange.setFill()
        path.fill()
        
        UIColor.purple.setStroke()
        path.stroke()
    }
    
    func createRectangle() {
        
        path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        
        path.close()
    }
    
    func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()
    }
    
//    override func draw(_ rect: CGRect) {
////        self.createRectangle()
////        self.createTriangle()
//        
//        // 椭圆
////        self.path = UIBezierPath(ovalIn: self.bounds)
//        //圆
////        self.path = UIBezierPath(ovalIn: CGRect(x: self.frame.size.width/2-self.frame.size.height/2, y: 0.0, width: self.frame.size.height, height: self.frame.size.height))
//        
//        // 圆形角
////        path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 15.0)
//        // 部分圆形角
////        path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 15.0, height: 0.0))
//        // 圆弧 半圆
////        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
////                            radius: self.frame.size.height/2,
////                            startAngle: CGFloat(M_PI),
////                            endAngle: 0.0,
////                            clockwise: true)
////        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
////                            radius: self.frame.size.height/2,
////                            startAngle: CGFloat(3*M_PI/2),
////                            endAngle: CGFloat(M_PI/2),
////                            clockwise: false)
//        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
//                            radius: self.frame.size.height/2,
//                            startAngle: radian * 240.0,
//                            endAngle: radian * 15.0,
//                            clockwise: false)
//        
//        
//        UIColor.orange.setFill()
//        path.fill()
//        
//        UIColor.purple.setStroke()
//        path.stroke()
//    }
    
    func simpleShapeLayer() {
        self.createRectangle()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = self.path.cgPath
        
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.strokeColor = UIColor.brown.cgColor
        shapeLayer.lineWidth = 3.0
        
        self.layer.addSublayer(shapeLayer)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(M_PI) / 180.0
    }
}
