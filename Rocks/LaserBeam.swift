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
        private let sprite = SKSpriteNode (color: UIColor.cyan , size: CGSize(width: 0.5, height: 10))
        private var origin = CGVector     (dx: 0, dy: 0)
        private var path   = CGVector     (dx: 0, dy: 10)

        func fire (o: CGVector) -> SKSpriteNode {
            sprite.name                            = "laserbeam"
            sprite.physicsBody                     = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.categoryBitMask    = laserbeamCollisionCat
            sprite.physicsBody?.contactTestBitMask = asteroidCollisionCat
            sprite.physicsBody?.collisionBitMask   = asteroidCollisionCat
            
            origin.dx = o.dx
            origin.dy = o.dy
            
            sprite.position.x = origin.dx
            sprite.position.y = origin.dy
            
            return sprite
        }
        
        func update () {
            sprite.position.x += path.dx
            sprite.position.y += path.dy
        }
        
        func getPosition () -> CGVector {
            return CGVector (
                dx: sprite.position.x,
                dy: sprite.position.y
            )
        }
        
        func cull () {
            sprite.run(SKAction.removeFromParent())
        }
    }
}