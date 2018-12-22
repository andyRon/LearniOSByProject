//
//  ViewController.swift
//  slideOutMenu
//
//  Created by andyron<http://andyron.com> on 2018/5/26.
//  Copyright © 2018年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sideMenuConstraints: NSLayoutConstraint!
    
    var isSlideMenuHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sideMenuConstraints.constant = -140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func organizeBtnPressed(_ sender: UIBarButtonItem) {
        if isSlideMenuHidden {
            sideMenuConstraints.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                })
        } else {
            sideMenuConstraints.constant = -140
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        isSlideMenuHidden = !isSlideMenuHidden
    }
    
}

