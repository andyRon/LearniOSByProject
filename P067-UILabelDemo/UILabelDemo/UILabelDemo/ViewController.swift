//
//  ViewController.swift
//  UILabelDemo
//
//  Created by andyron on 2017/6/20.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let labelText = "剑、宝石和镜子。\n剑象征着武器的力量。\n宝石象征着金钱的力量。镜子象征着自知的力量。"

        label.text = labelText
        
        
        label.textColor = UIColor.brown
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightThin)
        label.textAlignment = .justified
        // 文本阴影颜色，默认为nil，没有阴影
//        label.shadowColor = UIColor.red
        // 文本阴影编译量。此处表示向正下方偏移10
        label.shadowOffset = CGSize(width: 0, height: 10)
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 0
        
        // 富文本使用
        let attrStr = NSMutableAttributedString(string: labelText)
        attrStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 30.0), range: NSMakeRange(5, 2))
        attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(13, 2))
        label.attributedText = attrStr
        // UILabel的高度自适应文本
        label.sizeToFit()
        
//        label.isHighlighted = true
//        label.highlightedTextColor = UIColor.blue
//        label.isEnabled = false
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 20.0
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

