//
//  GameScene.swift
//  Label
//
//  Created by andyron on 2017/6/10.
//  Copyright © 2017年 andyron. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let label = SKLabelNode(text: "Hello SpriteKit!")
    
    // runs immediately after the scene is presented by its corresponding view
    override func didMove(to view: SKView) {
        addChild(label)
        label.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        label.fontSize = 45
        label.fontColor = SKColor.yellow
        label.fontName = "Avenir"
    }
}
