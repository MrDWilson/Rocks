//
//  AsteroidFragment.swift
//  Rocks
//
//  Created by Ryan Needham on 14/02/2017.
//  Copyright © 2017 Ryan Needham. All rights reserved.
//

/*
 
 ISSUES:
    - Ship needs more mass
    - Position being set after asteroid reset to top
 */
 
import SpriteKit

func betterRand () -> CGFloat {
    var ting: CGFloat = CGFloat((arc4random_uniform(100) % 100)) / 100.0
    
    if (arc4random_uniform(100) > 50) {
        ting *= -1
    }
    
    return ting
}

extension GameScene {
    
    class AsteroidFragment {
        private let sprite: SKSpriteNode!
        private var path: CGVector!
        
        init () {
            sprite = SKSpriteNode(color: AsteroidColor.Brown.toUIColor, size: CGSize(width: 8, height: 8))
            path = CGVector(dx: betterRand(), dy: CGFloat(Float(arc4random_uniform(100)) / 100) * -1)
            sprite.name = "fragment"
            sprite.physicsBody                     = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.isDynamic          = true
            sprite.physicsBody?.categoryBitMask    = asteroidCollisionCat
            sprite.physicsBody?.contactTestBitMask = playerCollisionCat
            sprite.physicsBody?.collisionBitMask   = playerCollisionCat
            sprite.physicsBody!.mass               = 0.0005
            sprite.physicsBody?.allowsRotation     = true
        }
        
        func setPosition (x: CGFloat, y: CGFloat) {
            sprite.position = CGPoint(x: x, y: y)
        }
        
        func getSprite () -> SKSpriteNode { return sprite }
        
        func boom () {
            sprite.physicsBody?.applyImpulse(path, at: sprite.position)
        }
        
        /**
         *  Move along vector path
         */
        func update () {
            sprite.position.x += path.dx
            sprite.position.y += path.dy
            
            //path.dx -= (path.dx * 0.1)
            
            // keep moving down
            sprite.position.y -= 1
            
            
            // print("x: \(sprite.position.x), y: \(sprite.position.y)")
        }
        
        /** 
         *
         */
        func cull () {
            sprite.removeFromParent()
            sprite.alpha = 0
        }
    }
}

