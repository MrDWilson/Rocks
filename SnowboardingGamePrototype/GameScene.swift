//
//  GameScene.swift
//  SnowboardingGamePrototype
//
//  Created by user on 07/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var lastYieldTimeInterval = TimeInterval()
    var lastUpdateInterval = TimeInterval()
    
    var player:  SKSpriteNode!
    
    var timer = Timer()
    var score = Counter()
    var scoreLabel:SKLabelNode!
    

    // On-Start
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector (dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        
        spawnPlayer()
        
        increaseScore()
        
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel.text = String(score.getCount())
        scoreLabel.fontSize = 20
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x:self.size.width, y:self.size.height)
        
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
    }
    
    // On-Update delegate
    func updateWithLast (lastUpdate: CFTimeInterval) {
        lastYieldTimeInterval += lastUpdate
        if (lastYieldTimeInterval > 0.6) {
            lastYieldTimeInterval = 0
            spawnAsteroid()
        }
    }
    
    // On-Collision
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.node?.name == "PlayerOne") {
            print("COLLISION - GAME OVER");
        }
    }
    
    class Counter {
        var count = 0
        func increment() {
            count += 1
        }
        func reset() {
            count = 0
        }
        func getCount() -> Int {
            return count
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
