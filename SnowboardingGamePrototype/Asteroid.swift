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
        private let sprite = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 10, height: 10))
        private var actionArray = [SKAction]()
        private let speed = 5
        private let spin = Int(arc4random_uniform(5))
        private let size = Int(arc4random_uniform(10))
        
        func spawn (x: Int, y: Int) -> SKSpriteNode {
            
            // Give name, size and position
            sprite.name = "asteroid"
            sprite.size.width = sprite.size.width * CGFloat(size)
            sprite.size.height = sprite.size.height * CGFloat(size)
            sprite.position = CGPoint(x: x, y: y)
            
            // Give graphics
            sprite.texture = SKTexture(imageNamed: "Asteroid")
            
            // Give physics components
            sprite.physicsBody?.isDynamic = true
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.categoryBitMask = collision.asteroid
            sprite.physicsBody?.collisionBitMask = collision.player
            sprite.physicsBody?.contactTestBitMask = collision.asteroid
            
            // Give motion
            //actionArray.append(SKAction.rotate(byAngle: 360, duration: TimeInterval(spin)))
            actionArray.append(SKAction.move(to: CGPoint(x: sprite.position.x, y: -sprite.size.height), duration: TimeInterval(speed)))
            
            actionArray.append(SKAction.removeFromParent()); // ISSUE: Asteroids aren't removing themselves to be garbage collected
            sprite.run(SKAction.sequence(actionArray))
            
            sprite.zPosition = -1
            
            // add to scene
            return sprite
        }
    }
}
