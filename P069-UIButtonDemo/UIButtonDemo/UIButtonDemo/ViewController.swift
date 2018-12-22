//
//  ViewController.swift
//  UIButtonDemo
//
//  Created by andyron on 2017/6/23.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "link style icon")
        
//        let button1 = UIButton(type: .infoDark)
//        button1.frame = CGRect(x: 30, y: 30, width: 100, height: 40)
//
//        self.view.addSubview(button1)
//        
//        let button2 = UIButton(type: .infoLight)
//        button2.frame = CGRect(x: 30, y: 80, width: 100, height: 40)
//        
//        self.view.addSubview(button2)
//        
//        
//        let button3 = UIButton(type: .contactAdd)
//        button3.frame = CGRect(x: 30, y: 130, width: 100, height: 40)
//        
//        self.view.addSubview(button3)
//        
//        let button4 = UIButton(type: .detailDisclosure)
//        button4.frame = CGRect(x: 30, y: 180, width: 100, height: 40)
//        
//        self.view.addSubview(button4)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 24)
        btn.center = CGPoint(x: self.view.frame.size.width/2, y: 200)
        btn.backgroundColor = UIColor.white
        //
        btn.setImage(image, for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2)
        
        btn.contentHorizontalAlignment = .left
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2)
        
        btn.setTitle("link", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.layer.cornerRadius = 12
        
        btn.tag = 1001
        
        
//        btn.addTarget(self, action: #selector(ViewController.touchUpInside), for: .touchUpInside)
        // 删除所有事件
//        btn.removeTarget(nil, action: nil, for: .allEvents)
        self.view.addSubview(btn)

        
        let btn1 = UIButton(type: .custom)
        btn1.frame = CGRect(x: self.view.frame.size.width/2 - 25, y: 300, width: 50, height: 25)
        
        btn1.setImage(image, for: .normal)
        
        
        btn1.setTitle("link", for: .normal)
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn1.setTitleColor(UIColor.blue, for: .normal)
        btn1.setTitleColor(.red, for: .normal)
        
        btn1.layer.borderWidth = 1
        btn1.layer.borderColor = UIColor.darkGray.cgColor
        btn1.layer.cornerRadius = 12
        // 解决titleLabel为零的问题
        btn1.layoutIfNeeded()
        let titleFrame = btn1.titleLabel!.frame
        let imageFrame = btn1.imageView!.frame
        let space = (titleFrame.origin.x) - (imageFrame.origin.x) - (imageFrame.size.width)
        
        print(titleFrame)
        print(imageFrame)
        
        btn1.imageEdgeInsets = UIEdgeInsetsMake(0, (titleFrame.size.width) + space, 0, -((titleFrame.size.width) + space))
        btn1.titleEdgeInsets = UIEdgeInsetsMake(0, -(titleFrame.origin.x - imageFrame.origin.x), 0,
                                                (titleFrame.origin.x) - (imageFrame.origin.x))
        
        
        self.view.addSubview(btn1)
        
        
        
        
    
    }
    func touchUpInside() {
        print("touchUpInside")
    }



}

