//
//  GameScene.swift
//  SnowboardingGamePrototype
//
//  Created by user on 07/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//
//  as if theres no fucking ++ or -- operator in swift 3...
//
//  as if an if statement doesn't compile without braces...

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var lastYieldTimeInterval = TimeInterval()
    var lastUpdateInterval    = TimeInterval()
    
    var player: Player = Player()
    
    var timer = Timer()
    var score = Counter()
    var scoreLabel:SKLabelNode!
    var gameOverLabel:SKLabelNode!

    // On-Start
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector (dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        
        addChild(player.spawn(x: Int(self.size.width / 2), y: 60))
        
        increaseScore()
        
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.text = String(score.getCount())
        scoreLabel.fontSize = 20
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x:6, y:6)
        addChild(scoreLabel);
        
    }
    
    // On-Update
    override func update(_ currentTime: TimeInterval) {
        var timeSinceLastUpdate = currentTime - lastUpdateInterval
        lastUpdateInterval = currentTime
        
        if (timeSinceLastUpdate > 2) {
            timeSinceLastUpdate = 1/60
            lastUpdateInterval = currentTime
        }
        
        updateWithLast(lastUpdate: timeSinceLastUpdate)
        scoreLabel.text = String(score.getCount())
        
        player.update()
    }
    
    // On-Update delegate I
    func updateWithLast (lastUpdate: CFTimeInterval) {
        lastYieldTimeInterval += lastUpdate
        if (lastYieldTimeInterval > 0.6) {
            lastYieldTimeInterval = 0
            let asteroid = Asteroid()
            
            addChild ( asteroid.spawn(
                x: Int(arc4random_uniform(UInt32(self.size.width))),
                y: Int(self.size.height))
            )
        }
    }
    
    // On-Collision
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.node?.name == "PlayerOne") {
            gameOverLabel = SKLabelNode(fontNamed: "Arial")
            gameOverLabel.text = String("GAME OVER")
            gameOverLabel.fontSize = 32
            gameOverLabel.horizontalAlignmentMode = .center
            gameOverLabel.color = UIColor.red
            gameOverLabel.position = CGPoint(x:self.size.width / 2, y:self.size.height / 2)
            addChild(gameOverLabel);
            
            print("collision detected");
            
            score.reset()
        }
    }

    //Increase score
    func increaseScore() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateScore), userInfo: nil, repeats: true)
    }
    
    func updateScore() {
        score.increment()
        print("Score:", score.getCount())
    }
}
