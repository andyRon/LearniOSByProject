//
//  ViewController.swift
//  LongPressGesturesTutorial
//
//  Created by andyron on 2017/4/12.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleGesture(_ sender: AnyObject) {
        
        if sender.state == UIGestureRecognizerState.began {
            let alertController = UIAlertController(title: nil, message: "Long-Press Gesture Detected", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

}

