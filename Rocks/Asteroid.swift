/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  Asteroid.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    
    class Asteroid {
        private let sprite  = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 10, height: 10))
        private let ghost   = SKLabelNode()
        private var size    = 2 + Int(arc4random_uniform(8))
        private let velocity = CGVector(dx: 0, dy: 0 - (2 + Int(arc4random_uniform(6))))
        
        private var xConfine:Int      = 1080
        private var yConfine:Int      = 1920 // 6 plus default
        
        private var textureCache: TextureCache!
        
        private var hit = false
        
        func setXConfine (con: Int) { xConfine = con - Int(sprite.size.width) }
        func setYConfine (con: Int) { yConfine = con + Int(sprite.size.width) }
        
        func spawn (textureCache: TextureCache) -> SKSpriteNode {
            self.textureCache = textureCache
            
            // Give name, size and position
            sprite.name       = "asteroid"
            sprite.xScale     = CGFloat(size)
            sprite.yScale     = CGFloat(size)
            sprite.position.x = CGFloat(arc4random_uniform(UInt32(xConfine - Int(sprite.size.width))))
            sprite.position.y = CGFloat(yConfine + 800 + Int(arc4random_uniform(750)))
            
            // Give graphics
            let ting = 1 + Int(arc4random_uniform(4))
            sprite.texture = textureCache.getCached(key: String("Asteroid_" + String(describing: ting)))
            
            // Give physics components
            sprite.physicsBody                     = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.isDynamic          = true
            sprite.physicsBody?.categoryBitMask    = asteroidCollisionCat
            sprite.physicsBody?.contactTestBitMask = playerCollisionCat
            sprite.physicsBody?.collisionBitMask   = playerCollisionCat
            sprite.physicsBody!.mass               = CGFloat(size)
            sprite.physicsBody?.allowsRotation     = true
            
            // move to back or render queue
            sprite.zPosition = -1
            sprite.zRotation = CGFloat (arc4random_uniform(360))
            
            // ghost
            ghost.text = String("100")
            ghost.fontColor = UIColor.purple
            ghost.fontSize = 100
            
            // add to scene
            return sprite
        }
        
        func update () {
            sprite.position.x += velocity.dx
            sprite.position.y += velocity.dy
            
            if (sprite.position.y < 0 - (sprite.size.height * 2)) {
                reuse()
            }
            
            sprite.physicsBody?.allContactedBodies().forEach {
                if ($0.node?.name == "laserbeam") {
                    destroyed()
                }
            }
        }
        
        func destroyed () {
            reuse()
        }
        
        func culled () {
            sprite.removeFromParent()
        }
        
        private func reuse () {
            
            
            // randomise appearence
            size          = 2 + Int(arc4random_uniform(8))
            sprite.xScale = CGFloat(size)
            sprite.yScale = CGFloat(size)
            sprite.zRotation = CGFloat (arc4random_uniform(360))
            
            // reuse
            sprite.position.x = CGFloat(arc4random_uniform(UInt32(xConfine)))
            sprite.position.y = CGFloat(yConfine +  800 + Int(arc4random_uniform(750)))
            
        }
    }
}
