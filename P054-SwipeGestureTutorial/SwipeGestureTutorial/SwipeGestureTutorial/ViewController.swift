//
//  ViewController.swift
//  SwipeGestureTutorial
//
//  Created by andyron on 2017/4/12.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var swipeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipes(sender:)))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipes(sender:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleSwipes(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            print("swipe left")
            let labelPostion = CGPoint(x: self.swipeLabel.frame.origin.x - 50.0, y: self.swipeLabel.frame.origin.y)
            swipeLabel.frame = CGRect(x: labelPostion.x, y: labelPostion.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
        }
        
        if sender.direction == .right {
            print("swipe right")
            let labelPostion = CGPoint(x: self.swipeLabel.frame.origin.x + 50.0, y: self.swipeLabel.frame.origin.y)
            swipeLabel.frame = CGRect(x: labelPostion.x, y: labelPostion.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
        }
        
    }
}

