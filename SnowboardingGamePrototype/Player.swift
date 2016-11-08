//
//  Player.swift
//  SnowboardingGamePrototype
//
//  Created by Ryan Needham on 08/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit
import UIKit

extension GameScene {
    class Player {
        private let sprite = SKSpriteNode(color: UIColor.gray, size: CGSize(width: 24, height: 24))
        private var movingLeft:  Bool = false
        private var movingRight: Bool = false
        
        func startMovingRight () { movingRight = true }
        func startMovingLeft  () { movingLeft  = true }
        func stopMovingRight  () { movingRight = false }
        func stopMovingLeft   () { movingLeft  = false }
        
        
        func spawn (x: Int, y: Int) -> SKSpriteNode {
             
            // Give name, position
            sprite.name = "PlayerOne"
            sprite.position = CGPoint(x: x , y: y)
            
            // Give graphics
            sprite.texture = SKTexture(imageNamed: "Spaceship") // add spaceship texture to sprite
            
            // Give physics
            sprite.physicsBody?.isDynamic = false
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width, height: sprite.size.height))
            sprite.physicsBody?.categoryBitMask = collision.player
            sprite.physicsBody?.collisionBitMask = 0
            sprite.physicsBody?.contactTestBitMask = collision.asteroid

            return sprite
        }
        
        func update () {
            if (movingLeft) {
                sprite.position.x += 6
            }
            
            if (movingRight) {
                sprite.position.x -= 6
            }
            
        }
    }
}
