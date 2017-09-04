//
//  ViewController.swift
//  clock
//
//  Created by andyron on 2017/9/4.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - 懒加载
    // 秒针
    lazy var secondHandView: UIView = {
        let secondHandView = UIView()
        secondHandView.backgroundColor = UIColor.red
        secondHandView.bounds = CGRect(x: 0, y: 0, width: 1, height: 60)
        
        secondHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)

        return secondHandView
    }()
    
    // 分针
    lazy var minuteHandView: UIView = {
        let minuteHandView = UIView()
        minuteHandView.backgroundColor = UIColor.darkGray
        minuteHandView.bounds = CGRect(x: 0, y: 0, width: 3, height: 60)
        
        minuteHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        return minuteHandView
    }()
    
    // 时针
    lazy var hourHandView: UIView = {
        let hourHandView = UIView()
        hourHandView.backgroundColor = UIColor.darkGray
        hourHandView.bounds = CGRect(x: 0, y: 0, width: 3, height: 45)
        
        hourHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        return hourHandView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let dialLayer = CALayer()
        dialLayer.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        dialLayer.position = self.view.center
        dialLayer.contents = UIImage(named: "clock")?.cgImage
        
        view.layer.addSublayer(dialLayer)
        
        // 把秒针、分针、时针添加到view中
        secondHandView.center = view.center
        self.view.addSubview(secondHandView)
        minuteHandView.center = view.center
        self.view.addSubview(minuteHandView)
        hourHandView.center = view.center
        self.view.addSubview(hourHandView)
        
        // 创建CADisplayLink，并将其添加到主线程中
        let link = CADisplayLink(target: self, selector: #selector(ViewController.clockRunning))
        link.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        
        
    }

    func clockRunning() {
        let tZone = TimeZone.current
        var calendar = Calendar.current
        let currentDate = Date()
        calendar.timeZone = tZone
        
        let currentTime = calendar.dateComponents([Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: currentDate)
        
        // 根据当前秒、分、时数分别计算秒针、分针、时针偏转弧度
        let secondAngle = CGFloat ( Double(currentTime.second!) * (Double.pi * 2.0 / 60) )
        secondHandView.transform = CGAffineTransform(rotationAngle: secondAngle)
        
        let minuteAngle = CGFloat ( Double(currentTime.minute!) * (Double.pi * 2.0 / 60) )
        minuteHandView.transform = CGAffineTransform(rotationAngle: minuteAngle)
        
        let hourAngle = CGFloat ( Double(currentTime.hour!) * (Double.pi * 2.0 / 12) )
        hourHandView.transform = CGAffineTransform(rotationAngle: hourAngle)
    }
    


}

