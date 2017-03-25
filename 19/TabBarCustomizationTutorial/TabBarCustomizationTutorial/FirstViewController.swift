//
//  FirstViewController.swift
//  TabBarCustomizationTutorial
//
//  Created by andyron on 2017/3/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let tabBar = self.tabBarController?.tabBar else { return }
        
        tabBar.tintColor = UIColor.white
        tabBar.barTintColor = UIColor.black
        tabBar.unselectedItemTintColor = UIColor.yellow
        
        guard  let tabBarItem = self.tabBarItem  else {
            return
        }
        
        tabBarItem.badgeValue = "88"
        tabBarItem.badgeColor = UIColor.blue
    }




}

