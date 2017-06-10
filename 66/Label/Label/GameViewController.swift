//
//  GameViewController.swift
//  Label
//
//  Created by andyron on 2017/6/10.
//  Copyright © 2017年 andyron. All rights reserved.
//

import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        let scene = GameScene(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
    }

   
}
