/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  Player.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class Player {
        private let sprite = SKSpriteNode(color: UIColor.gray, size: CGSize(width: 24, height: 24))
        private var movingLeft:  Bool = false
        private var movingRight: Bool = false
        private var name = String ("PlayerOne")
        
        func getName() -> String { return name! }
        
        func startMovingRight () { movingRight = true }
        func startMovingLeft  () { movingLeft  = true }
        func stopMovingRight  () { movingRight = false }
        func stopMovingLeft   () { movingLeft  = false }
        
        func rotateLeft  () { sprite.run(SKAction.rotate(byAngle: 2, duration:1)) }
        func rotateRight () { sprite.run(SKAction.rotate(byAngle: -2, duration:1)) }
        
        func moveTo (x: Int, y: Int) { sprite.position = CGPoint(x: x, y: y) }
        
        func spawn (x: Int, y: Int) -> SKSpriteNode {
             
            // Give name, position
            sprite.name = String("PlayerOne")
            sprite.position = CGPoint(x: x , y: y)
            
            // Give graphics
            sprite.texture = SKTexture(imageNamed: "Ship") // add spaceship texture to sprite
            
            sprite.size.width = 64
            sprite.size.height = 64
            
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
