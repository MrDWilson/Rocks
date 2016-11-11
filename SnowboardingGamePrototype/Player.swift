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
        private var velocity    = CGVector(dx: 0, dy: 0)
        private var name        = String("PlayerOne")
        private var lasers      = NSMutableArray()
        private let score       = Counter()
        private var ammo        = 20
        private let AMMO_MAX    = 20
        private var health      = 20
        private let HEALTH_MAX  = 20
        private var exploding   = false
        private let particalEffect = SKEmitterNode(fileNamed: "ExplosionParticle.sks")
        
        func getName     () -> String  { return name! }
        func getPosition () -> CGPoint { return sprite.position }
        func getHealth   () -> Int     { return health }
        func getAmmo     () -> Int     { return ammo }
        func getScore    () -> Int     { return score.getCount() }
        
        func moveRight () { velocity.dx += 10 }
        func moveLeft  () { velocity.dx -= 10 }
        func moveTo (x: Int, y: Int) {
            particalEffect?.removeFromParent()          // delete particle effect
            health = HEALTH_MAX                         // reset health
            ammo   = AMMO_MAX                           // reset ammo
            sprite.position = CGPoint(x: x, y: y)       // reset position
            score.reset()                               // reset score
            sprite.physicsBody!.allowsRotation = false
            sprite.zRotation = 0
        }
        
        func spawn (x: Int, y: Int) -> SKSpriteNode {
             
            // Give Name, Position
            sprite.name = String("PlayerOne")
            sprite.position = CGPoint(x: x , y: y)
            
            // Give graphics
            sprite.texture          = SKTexture(imageNamed: "Ship") // add spaceship texture to sprite
            sprite.size.width       = 42                            // reset size after adding sprite
            sprite.size.height      = 42
            
            // Give physics
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.isDynamic           = false
            sprite.physicsBody?.categoryBitMask     = collision.player
            sprite.physicsBody?.collisionBitMask    = 0
            sprite.physicsBody?.contactTestBitMask  = collision.asteroid

            // Give Movement
            sprite.physicsBody? = SKPhysicsBody(rectangleOf: sprite.frame.size)
            sprite.physicsBody!.affectedByGravity               = false
            sprite.physicsBody!.mass                            = 0.02
            sprite.physicsBody!.allowsRotation                  = false
            sprite.physicsBody!.usesPreciseCollisionDetection   = true
            sprite.physicsBody!.linearDamping                   = 3
            
            // Give Particle Effect
            particalEffect?.name = String("explosion")
            particalEffect?.position = CGPoint(x: 0, y: 0)
            
            sprite.zPosition = -1

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
            for laser in (lasers as NSArray as! [LaserBeam]) { laser.update() }
            cullLasers()
        }
        
        func pickupHealth () {
            if      (health < HEALTH_MAX - 5) { health += 5 }
            else if (health > HEALTH_MAX - 5) { health = HEALTH_MAX }
        }
        
        func pickupAmmo () {
            if      (ammo < AMMO_MAX - 5) { ammo += 5 }
            else if (ammo > AMMO_MAX - 5) { ammo = AMMO_MAX }
        }
        
        func pickupPoints () {
            for _ in 1...100 { score.increment() }
        }
        
        func give (points: Int) {
            for _ in 1...points { score.increment() }
        }
        
        func takeDamage () {
            if      (health <  2) { health = 0 }
            else if (health >= 2) { health -= 1; }
        }
        
        func fireLaser () -> SKSpriteNode {
            if (ammo > 0) {
                let beam = LaserBeam()
                lasers.add(beam)
                ammo -= 1
                return beam.fire(o: CGVector(dx: sprite.position.x, dy: sprite.position.y))
            }
            
            return SKSpriteNode() // BAD, BAD, BAD (but it works for now)
        }
        
        func explode () {
            if (!exploding) {
                particalEffect?.removeFromParent()
                sprite.addChild(particalEffect!)
            }
        }
        
        func cullLasers () {
            for laser in (lasers as NSArray as! [LaserBeam]) {
                if (laser.getPosition().dy > 1000) {
                    laser.cull()
                }
            }
        }
        
        func clearLasers () {
            for laser in (lasers as NSArray as! [LaserBeam]) {
                laser.cull()
            }
        }
        
        func spin() {
            sprite.physicsBody!.allowsRotation = true
        }
    }
}
