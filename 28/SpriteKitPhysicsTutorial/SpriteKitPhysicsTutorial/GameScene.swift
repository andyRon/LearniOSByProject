//
//  GameScene.swift
//  SpriteKitPhysicsTutorial
//
//  Created by andyron on 2017/3/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.white
        
        scene!.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.run(
            SKAction.repeat(SKAction.sequence([SKAction.run(self.createBall), SKAction.wait(forDuration: 0.05)]), count: 200)
        )
    }
    
    func createBall() {
        let ball: SKSpriteNode = SKSpriteNode(imageNamed: "ball")
        
        ball.position = CGPoint(x: CGFloat(Int(arc4random()) % Int(self.size.width)), y: self.size.height - ball.size.height)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        self.addChild(ball)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
