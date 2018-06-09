//
//  MenuViewController.swift
//  ARTumblr
//
//  Created by andyron<http://andyron.com> on 2018/6/9.
//  Copyright © 2018年 andyron. All rights reserved.
//

import UIKit

class MenuViewController: ViewController {

    let transitionManger = TransitionManager()
    
    @IBOutlet weak var textPostIcon: UIImageView!
    @IBOutlet weak var textPostLabel: UILabel!
    
    @IBOutlet weak var photoPostIcon: UIImageView!
    @IBOutlet weak var photoPostLabel: UILabel!
    
    @IBOutlet weak var quotePostIcon: UIImageView!
    @IBOutlet weak var quotePostLabel: UILabel!
    
    @IBOutlet weak var linkPostIcon: UIImageView!
    @IBOutlet weak var linkPostLabel: UILabel!
    
    @IBOutlet weak var chatPostIcon: UIImageView!
    @IBOutlet weak var chatPostLabel: UILabel!
    
    @IBOutlet weak var audioPostIcon: UIImageView!
    
    @IBOutlet weak var audioPostLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.transitioningDelegate = self.transitionManger

    }


}
