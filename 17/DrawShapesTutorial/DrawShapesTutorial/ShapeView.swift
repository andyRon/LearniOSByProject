//
//  ShapeView.swift
//  DrawShapesTutorial
//
//  Created by andyron on 2017/3/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ShapeView: UIView {

    var currentShapType: Int = 0
    
    init(frame: CGRect, shape: Int) {
        super.init(frame: frame)
        self.currentShapType = shape
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override func draw(_ rect: CGRect) {
        switch currentShapType {
        case 0:
            drawRectangle()
        case 1:
            drawLines()
        case 2:
            drawCircle()
        default:
            break
        }
    }

    func drawLines() {
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.beginPath()
        ctx.move(to: CGPoint(x: 20.0, y: 20.0))
        ctx.addLine(to: CGPoint(x: 250.0, y: 100.0))
        ctx.addLine(to: CGPoint(x: 100.0, y: 200.0))
        ctx.setLineWidth(5)
        
        ctx.closePath()
        ctx.strokePath()
    }
    
    func drawRectangle() {
        let center = CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        let rectangleWidth: CGFloat = 100.0
        let rectangleHeight: CGFloat = 100.0
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.addRect(CGRect(x: center.x - rectangleWidth/2, y: center.y - rectangleHeight/2, width: rectangleWidth, height: rectangleHeight))
        ctx.setLineWidth(5)
        ctx.setStrokeColor(UIColor.darkGray.cgColor)
        ctx.strokePath()
        
        ctx.setFillColor(UIColor.green.cgColor)
        ctx.addRect(CGRect(x: center.x - rectangleWidth/2, y: center.y - rectangleHeight/2, width: rectangleWidth, height: rectangleHeight))
        
        ctx.fillPath()
    }
    
    func drawCircle() {
        let center = CGPoint(x: self.frame.size.width/2.0, y: self.frame.size.height/2.0)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.setLineWidth(5)
        
        let radius: CGFloat = 100.0
        let endAngle: CGFloat = CGFloat(2 * M_PI)
        
        ctx.addArc(center: CGPoint(x: center.x, y: center.y), radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
        
        ctx.strokePath()

        
    }
}
