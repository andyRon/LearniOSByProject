//
//  CircleView.swift
//  DrawingCirclesTutorial
//
//  Created by andyron on 2017/4/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import CoreGraphics

class CircleView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(5.0)
        
        UIColor.red.set()
        
        let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        //
        context.addArc(center: center, radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2), clockwise: false)
        
   
        context.strokePath()
    }
    

}
