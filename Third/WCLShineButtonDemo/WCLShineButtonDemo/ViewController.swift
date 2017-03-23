//
//  ViewController.swift
//  WCLShineButtonDemo
//
//  Created by andyron on 2017/3/23.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import WCLShineButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var param1 = WCLShineParams()
        param1.bigShineColor = UIColor(rgb: (153,152,38))
        param1.smallShineColor = UIColor.blue
        let bt1 = WCLShineButton(frame: .init(x: 30, y: 300, width: 60, height: 60), params: param1)
        bt1.fillColor = UIColor.green
        bt1.color = UIColor.red
        bt1.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(bt1)
        
        let bt2 = WCLShineButton(frame: .init(x: 130, y: 300, width: 60, height: 60), params: param1)
        bt2.fillColor = UIColor(rgb: (153,152,38))
        bt2.color = UIColor(rgb: (170,170,170))
        bt2.image = .like
        bt2.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(bt2)
    
        let bt3 = WCLShineButton(frame: .init(x: 230, y: 300, width: 60, height: 60), params: param1)
        bt3.fillColor = UIColor(rgb: (153,152,38))
        bt3.color = UIColor(rgb: (170,170,170))
        bt3.image = .smile
        bt3.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(bt3)
        
        let bt4 = WCLShineButton(frame: .init(x: 330, y: 300, width: 60, height: 60), params: param1)
        bt4.fillColor = UIColor(rgb: (153,152,38))
        bt4.color = UIColor(rgb: (170,170,170))
        bt4.image = .star
        bt4.addTarget(self, action: #selector(action), for: .touchUpInside)
        view.addSubview(bt4)
    
    }
    func action() {
        
    }


}

