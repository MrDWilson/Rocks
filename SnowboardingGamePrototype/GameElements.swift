//
//  GameElements.swift
//  SnowboardingGamePrototype
//
//  Created by user on 07/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit

struct collision {
    static let player:UInt32 = 0x00
    static let obstacle:UInt32 = 0x01
}

enum obstacleType: Int {
    case small  = 0
    case medium = 1
    case large  = 2
}

enum RowType: Int {
    case oneSmall   = 0
    case oneMedium  = 1
    case oneLarge   = 2
    case twoSmall   = 3
    case twoMedium  = 4
    case threeSmall = 5
}

extension GameScene {

    /** 
     *  addPlayer
     */
    func addPlayer () {
        // sprite, position and name
        player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: self.size.width / 2 , y: 220)
        player.name = "PlayerOne"
        
        // physics
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        player.physicsBody?.categoryBitMask = collision.player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = collision.obstacle
        
        addChild(player);
        
        initPos = player.position
    }
    
    func addObstacle (type: obstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor.white, size: CGSize(width: 0, height: 30))
    
        obstacle.name = "obstacle"
        obstacle.physicsBody?.isDynamic = true
        
        switch type {
            case.small:
                obstacle.size.width = self.size.width * 0.2
                break
            case.medium:
                obstacle.size.width = self.size.width * 0.35
                break
            case.large:
                obstacle.size.width = self.size.width * 0.75
                break
        }
        
        obstacle.position = CGPoint(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obstacle.size.width, height: obstacle.size.height))
        obstacle.physicsBody?.categoryBitMask = collision.obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        
        return obstacle
    }
    
    func addMovement (obstacle: SKSpriteNode) {
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: obstacle.position.x, y: -obstacle.size.height), duration: 5))
        actionArray.append(SKAction.removeFromParent());
        
        obstacle.run(SKAction.sequence(actionArray))
        
    }
    
    func addRow (type: RowType) {
        switch type {
            case .oneSmall:
                let obst = addObstacle(type: .small)
                obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
                addMovement(obstacle: obst)
                addChild(obst)
                break
            case .oneMedium:
                let obst = addObstacle(type: .medium)
                obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
                addMovement(obstacle: obst)
                addChild(obst)
                break
            case .oneLarge:
                let obst = addObstacle(type: .large)
                obst.position = CGPoint(x: self.size.width / 2, y: obst.position.y)
                addMovement(obstacle: obst)
                addChild(obst)
                break
            case .twoSmall:
                let obst1 = addObstacle(type: .small)
                let obst2 = addObstacle(type: .small)
                
                obst1.position = CGPoint(x: obst1.size.width + 50, y: obst1.position.y)
                obst2.position = CGPoint(x: self.size.width - obst2.size.width - 50, y: obst2.position.y)
            
                addMovement(obstacle: obst1)
                addMovement(obstacle: obst2)
                
                addChild(obst1)
                addChild(obst2)
            
                break
            case .twoMedium:
                let obst1 = addObstacle(type: .medium)
                let obst2 = addObstacle(type: .medium)
                
                obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y)
                obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst2.position.y)
                
                addMovement(obstacle: obst1)
                addMovement(obstacle: obst2)
                
                addChild(obst1)
                addChild(obst2)
                break
            case .threeSmall:
                let obst1 = addObstacle(type: .small)
                let obst2 = addObstacle(type: .small)
                let obst3 = addObstacle(type: .small)
                
                obst1.position = CGPoint(x: obst1.size.width / 2 + 50, y: obst1.position.y) // left
                obst2.position = CGPoint(x: self.size.width - obst2.size.width / 2 - 50, y: obst2.position.y) // right
                obst3.position = CGPoint(x: self.size.width / 2, y: obst2.position.y) // center
                
                addMovement(obstacle: obst1)
                addMovement(obstacle: obst2)
                addMovement(obstacle: obst3)
                
                addChild(obst1)
                addChild(obst2)
                addChild(obst3)
                break
        }
    }
    
    
}
