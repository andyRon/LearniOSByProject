//
//  GradientView.swift
//  DrawGradientsTutorial
//
//  Created by andyron on 2017/3/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class GradientView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.saveGState()
        // 颜色的范围
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let startColor = UIColor.red
        guard let startColorComponents = startColor.cgColor.components else { return }
        
        let endColor = UIColor.blue
        guard let endColorComponents = endColor.cgColor.components else { return }
        
        let colorComponents: [CGFloat] =
        [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        let locations: [CGFloat] = [0.0, 1.0]
        
        guard  let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents, locations: locations, count: 2) else {
            return
        }
        
        let startPoint = CGPoint(x: 0, y: self.bounds.height)
        let endPoint = CGPoint(x: self.bounds.width, y: self.bounds.height)
        
        ctx.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        ctx.restoreGState()
    }
 

}
