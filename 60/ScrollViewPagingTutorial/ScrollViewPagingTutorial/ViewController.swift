//
//  ViewController.swift
//  ScrollViewPagingTutorial
//
//  Created by andyron on 2017/4/18.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    var colors: [UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for index in 0..<colors.count {
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            
            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.scrollView.addSubview(subView)
        }
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(colors.count), height: self.scrollView.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

