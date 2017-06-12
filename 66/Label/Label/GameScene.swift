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
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap2))
        view.addGestureRecognizer(recognizer)
    }
    
    func tap(recognizer: UIGestureRecognizer) {
        // 点击的点在the scene’s coordinate system(原点在左上角)中的坐标
        let viewLocation = recognizer.location(in: view)
        print(viewLocation)
        let sceneLocation = convertPoint(fromView: viewLocation)
        print(sceneLocation)
        let moveToAction = SKAction.move(to: sceneLocation, duration: 1)
        label.run(moveToAction)
        
        
    }
    
    func tap2(recognizer: UIGestureRecognizer) {
        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        let moveByAction = SKAction.moveBy(x: sceneLocation.x - label.position.x, y: sceneLocation.y - label.position.y, duration: 1)

        // Reversed action  移动到目的地后立即返回原处
        let moveByReversedAction = moveByAction.reversed()
        let moveByActions = [moveByAction, moveByReversedAction]
        let moveSequence = SKAction.sequence(moveByActions)
        // 重复来回
//        let moveRepeatSequence = SKAction.repeat(moveSequence, count: 3)
//        label.run(moveRepeatSequence)
        // 永远来回
        let moveRepeatForeverSequence = SKAction.repeatForever(moveSequence)
        label.run(moveRepeatForeverSequence)

    }
}
