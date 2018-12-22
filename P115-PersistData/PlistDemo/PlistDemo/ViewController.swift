//
//  ViewController.swift
//  PlistDemo
//
//  Created by Andy Ron on 2018/8/23.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 获得路径
        let fileManager = FileManager.default
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = path?.appendingPathComponent("test.plist")
        
        // 存储。  其中atomically表示是否需要先写入一个辅助文件，再把辅助文件拷贝到目标文件地址。这是更安全的写入文件方法，一般都写true。
        let arr: NSArray = [123, 34]
        try? arr.write(toFile: (fileName?.path)!, atomically: true)
        
        // 读取
        let res = NSArray(contentsOfFile: (fileName?.path)!)
        
        print((fileName?.path)!)
        print(res)
        
        
    }


}

