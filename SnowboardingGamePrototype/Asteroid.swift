/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  Asteroid.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
// CGFloat(Int(arc4random_uniform(UInt32(self.size.width))))
import SpriteKit

extension GameScene {
    class Asteroid {
        private let sprite  = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 10, height: 10))
        private var actions = [SKAction]()
        private let speed   = 5
        private let spin    = Int(arc4random_uniform(5))
        private let size    = Int(arc4random_uniform(10))
        
        func spawn (x: Int, y: Int, texture: Cache) -> SKSpriteNode {
            
            // Give name, size and position
            sprite.name         = "asteroid"
            sprite.size.width   = sprite.size.width * CGFloat(size)
            sprite.size.height  = sprite.size.height * CGFloat(size)
            sprite.position     = CGPoint(x: x, y: y)
            
            // Give graphics
            sprite.texture = texture.getCached(key: "asteroid")
            
            // Give physics components
            sprite.physicsBody                     = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.isDynamic          = true
            sprite.physicsBody?.categoryBitMask    = collision.asteroid
            sprite.physicsBody?.collisionBitMask   = collision.player
            sprite.physicsBody?.contactTestBitMask = collision.asteroid
            
            // Give motion
            actions.append (SKAction.move(to: CGPoint(x: sprite.position.x, y: -sprite.size.height), duration: TimeInterval(speed)))
            actions.append (SKAction.removeFromParent());
            sprite.run     (SKAction.sequence(actions))
            
            // move to back or render queue
            sprite.zPosition = -1
            
            // add to scene
            return sprite
        }
    }
}
