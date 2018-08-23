//
//  ViewController.swift
//  UserDefaultsDemo
//
//  Created by Andy Ron on 2018/8/23.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 获得UserDefaults文件
        let userDefaults = UserDefaults.standard
        
        // 向文件中写入内容
        userDefaults.set("Andy", forKey: "name")
        userDefaults.set("male", forKey: "sex")
        userDefaults.set(100, forKey: "age")
        // 立即保存
        userDefaults.synchronize()
        // 读取文件
        let name = userDefaults.object(forKey: "name")
        let sex = userDefaults.object(forKey: "sex")
        let age = userDefaults.object(forKey: "age")
        
        
        print(name, sex, age)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

