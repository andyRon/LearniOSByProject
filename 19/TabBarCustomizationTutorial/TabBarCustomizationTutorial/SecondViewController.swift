//
//  SecondViewController.swift
//  TabBarCustomizationTutorial
//
//  Created by andyron on 2017/3/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        guard let tabBar = self.tabBarController?.tabBar else { return }
        
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = UIColor.cyan
        
        guard  let tabBarItem = self.tabBarItem  else {
            return
        }
        
        tabBarItem.badgeValue = "99"
        tabBarItem.badgeColor = UIColor.red
    }



}

