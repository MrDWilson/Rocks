/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  LaserBeam.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class LaserBeam {
        private let sprite = SKSpriteNode (color: UIColor.cyan, size: CGSize(width: 1.5, height: 10))
        private let bloom  = SKSpriteNode (color: UIColor.cyan, size: CGSize(width: 3, height: 10))
        private var origin = CGVector     (dx: 0, dy: 0)
        private var path   = CGVector     (dx: 0, dy: 10)

        func fire (o: CGVector, colour: UIColor) -> SKSpriteNode {
            sprite.name                            = "laserbeam"
            sprite.color                           = colour
            sprite.physicsBody                     = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.categoryBitMask    = laserbeamCollisionCat
            sprite.physicsBody?.contactTestBitMask = asteroidCollisionCat
            sprite.physicsBody?.collisionBitMask   = asteroidCollisionCat
            sprite.blendMode = .add
            
            bloom.name                             = "laserbeam"
            bloom.color                            = colour
            
            origin.dx = o.dx
            origin.dy = o.dy
            
            bloom.alpha = 0.5
            
            sprite.position.x = origin.dx
            sprite.position.y = origin.dy
            sprite.zPosition = -3
            
            // bloom trails one frame behind
            bloom.position.x = 0
            bloom.position.y = 1
            bloom.zPosition = -3
            bloom.blendMode = .add
            
            sprite.addChild(bloom);
            
            return sprite
        }
        
        func update () {
            sprite.position.x += path.dx
            sprite.position.y += path.dy
            

            
            sprite.physicsBody?.allContactedBodies().forEach {
                if ($0.node?.name == "asteroid") {
                    cull ()
                }
            }
        }
        
        func getPosition () -> CGVector {
            return CGVector (
                dx: sprite.position.x,
                dy: sprite.position.y
            )
        }
        
        func cull () {
            sprite.run(SKAction.removeFromParent())
            bloom.run(SKAction.removeFromParent())
        }
    }
}
