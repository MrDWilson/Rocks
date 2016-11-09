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
        private let sprite      = SKSpriteNode(color: UIColor.gray, size: CGSize(width: 24, height: 24))
        private var velocity    = CGVector     (dx: 0, dy: 0)
        private var name        = String ("PlayerOne")
        private var lasers      = NSMutableArray()
        
        func getName() -> String { return name! }
        
        func getPosition() -> CGPoint {
            return sprite.position   
        }
        
        func moveRight () { velocity.dx += 10 }
        func moveLeft  () { velocity.dx -= 10 }
        
        func moveTo (x: Int, y: Int) { 
            sprite.position = CGPoint(x: x, y: y) 
        }
        
        func spawn (x: Int, y: Int) -> SKSpriteNode {
             
            // Give name, position
            sprite.name = String("PlayerOne")
            sprite.position = CGPoint(x: x , y: y)
            
            // Give graphics
            sprite.texture          = SKTexture(imageNamed: "Ship") // add spaceship texture to sprite
            
            sprite.size.width       = 42
            sprite.size.height      = 42
            
            // Give physics
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.isDynamic           = false
            sprite.physicsBody?.categoryBitMask     = collision.player
            sprite.physicsBody?.collisionBitMask    = 0
            sprite.physicsBody?.contactTestBitMask  = collision.asteroid

            //Movement
            sprite.physicsBody? = SKPhysicsBody(rectangleOf: sprite.frame.size)
            sprite.physicsBody!.affectedByGravity               = false
            sprite.physicsBody!.mass                            = 0.02
            sprite.physicsBody!.allowsRotation                  = false
            sprite.physicsBody!.usesPreciseCollisionDetection   = true
            sprite.physicsBody!.linearDamping                   = 3

            return sprite
        }
        
        func update () {
            // apply velocity
            sprite.position.x += velocity.dx
            sprite.position.y += velocity.dy
            
            // dampen
            velocity.dx = velocity.dx / 2
            velocity.dy = velocity.dy / 2
            
            // laser
            for laser in (lasers as NSArray as! [LaserBeam]) {
                laser.update()
            }
            
            cullLasers()
        }
        
        func fireLaser () -> SKSpriteNode {
            let beam = LaserBeam()
            lasers.add(beam)
            return beam.fire(o: CGVector(dx: sprite.position.x, dy: sprite.position.y))
        }
        
        func cullLasers () {
            for laser in (lasers as NSArray as! [LaserBeam]) {
                if (laser.getPosition().dy > 1000) {
                    laser.cull()
                    print ("laser culled")
                }
            }
        }
        
        func clearLasers () {
            for laser in (lasers as NSArray as! [LaserBeam]) {
                laser.cull()
            }
            
            print("lasers cleared")
        }
    }
}
