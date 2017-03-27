//
//  ViewController.swift
//  MultipleOutletsTutorial
//
//  Created by andyron on 2017/3/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        for subview in view.subviews where subview.tag == 10 {
            let button = subview as! UIButton
            button.addTarget(self, action: #selector(ViewController.changeColorRed(_:)), for: .touchUpInside)
        }
        
        for subview in view.subviews where subview.tag == 20 {
            let button = subview as! UIButton
            button.addTarget(self, action: #selector(ViewController.changeColorGreen(_:)), for: .touchUpInside)
        }
    }
    
    func changeColorRed(_ sender: AnyObject) {
        let button: UIButton  = sender as! UIButton
        button.tintColor = UIColor.red
    }
    
    func changeColorGreen(_ sender: AnyObject) {
        let button: UIButton  = sender as! UIButton
        button.tintColor = UIColor.green
    }

}

