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
    
    var player:  SKSpriteNode!
    var initPos: CGPoint!
    
    func resetPlayerPosition () {
        player.position = initPos
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector (dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        
        addPlayer()
        addRow(type: RowType.twoSmall);
    }
    
    func addRandomRow () {
        let rand = Int(arc4random_uniform(6))
        
        addRow(type: RowType(rawValue: rand)!)
        
        switch(rand) {
            case 0:
                addRow(type: RowType(rawValue: 0)!)
                break
            case 1:
                addRow(type: RowType(rawValue: 1)!)
                break
            case 2:
                addRow(type: RowType(rawValue: 2)!)
                break
            case 3:
                addRow(type: RowType(rawValue: 3)!)
                break
            case 4:
                addRow(type: RowType(rawValue: 4)!)
                break
            case 5:
                addRow(type: RowType(rawValue: 5)!)
                break
            default:
                break
        }
    }
    
    var lastUpdateInterval = TimeInterval()
    var lastYieldTimeInterval = TimeInterval()
    
    func updateWithLast (lastUpdate: CFTimeInterval) {
        lastYieldTimeInterval += lastUpdate
        if (lastYieldTimeInterval > 0.6) {
            lastYieldTimeInterval = 0
            addRandomRow()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        var timeSinceLastUpdate = currentTime - lastUpdateInterval
        lastUpdateInterval = currentTime
        
        if (timeSinceLastUpdate > 2) {
            timeSinceLastUpdate = 1/60
            lastUpdateInterval = currentTime
        }
        
        updateWithLast(lastUpdate: timeSinceLastUpdate)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.node?.name == "PlayerOne") {
            print("HIT");
        }
    }
}
