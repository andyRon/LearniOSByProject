//
//  ViewController.swift
//  SnapBehaviourTutorial
//
//  Created by andyron on 2017/4/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var animator: UIDynamicAnimator!
    var snapBehaviour: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.userHasTapped(tap:)))
        self.view.addGestureRecognizer(tapGesture)
        
        animator = UIDynamicAnimator(referenceView: self.view)
    }

    func userHasTapped(tap: UITapGestureRecognizer) {
        let touchPoint = tap.location(in: self.view)
        if snapBehaviour != nil {
            animator.removeBehavior(snapBehaviour)
        }
        
        snapBehaviour = UISnapBehavior(item: imageView, snapTo: touchPoint)
        snapBehaviour.damping = 0.3
        animator.addBehavior(snapBehaviour)
    }

}

