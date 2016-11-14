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
        // the simple bit
        private let sprite              = SKSpriteNode(color: UIColor.gray, size: CGSize(width: 24, height: 24))
        
        // the less simple bit
        private let dstSprite_LeftWing  = SKSpriteNode ()
        private var leftWingVelocity    = CGVector     (dx: -4, dy: 1)
        private let dstSprite_RightWing = SKSpriteNode ()
        private var rightWingVelocity   = CGVector     (dx: 4, dy: 1)
        private let dstSprite_FrontBody = SKSpriteNode ()
        private var frontBodyVelocity   = CGVector     (dx: 1, dy: 4)
        private let dstSprite_BackBody  = SKSpriteNode ()
        private var backBodyVelocity    = CGVector     (dx: -1, dy: 4)
        private let explosionEffect     = SKEmitterNode(fileNamed: "ExplosionParticle.sks")
        private let thrusterEffect      = SKEmitterNode(fileNamed: "ThrusterParticle_" + String(describing: (1 + arc4random_uniform(5))) + ".sks")
        private var colourChangeArray   = [SKAction]()
        
        // the admin
        private var velocity            = CGVector(dx: 0, dy: 0)
        private var name                = String("player")
        private var lasers              = NSMutableArray()
        private let score               = Counter()
        private var ammo                = 25
        private let AMMO_MAX            = 25
        private var health              = 25
        private let HEALTH_MAX          = 25
        private var exploding           = false
        private var restingY            = 100
        
        func getName     () -> String  { return name! }
        func getPosition () -> CGPoint { return sprite.position }
        func getHealth   () -> Int     { return health }
        func getAmmo     () -> Int     { return ammo }
        func getScore    () -> Int     { return score.getCount() }
        
        func moveRight   () { velocity.dx += 10 }
        func moveLeft    () { velocity.dx -= 10 }
        
        func resetAt (x: Int, y: Int) {
            exploding = false
            restingY  = y

            
            // reassemble pieces

            
            dstSprite_LeftWing.removeFromParent  ()
            dstSprite_RightWing.removeFromParent ()
            dstSprite_FrontBody.removeFromParent ()
            dstSprite_BackBody.removeFromParent  ()

            resetFragmentedVelocities()
            
            // kill explosion and start thrust
            explosionEffect?.removeFromParent ()          // delete particle effec
            explosionEffect?.resetSimulation  ()
        
            sprite.addChild(thrusterEffect!)
            
            // reset health and ammo
            health = HEALTH_MAX
            ammo   = AMMO_MAX
            
            // move, reset rotation
            sprite.size.width  = 42                     // reset size after adding sprite
            sprite.size.height = 42                     // reset size after adding sprite
            sprite.position    = CGPoint(x: x, y: y)    // reset position
            //sprite.zRotation   = 0                      // Reset orientation
            sprite.isHidden = false
            
            colourChangeArray.removeAll()
            sprite.run(SKAction.colorize(with: UIColor.clear, colorBlendFactor: 0, duration: 0.1))
            
            score.reset()
        }
        
        func spawn (x: Int, y: Int) -> SKSpriteNode {
            restingY = y
            
            /* * * * * * * * * * * *
             *  Destruction Stuff
             * * * * * * * * * * * */
            dstSprite_LeftWing.name                             = "ShipPart"
            dstSprite_LeftWing.texture                          = SKTexture(imageNamed: "Ship_leftWing")
            dstSprite_LeftWing.size.width                       = 12
            dstSprite_LeftWing.size.height                      = 40
            dstSprite_LeftWing.position                         = CGPoint(x: -14, y: 0)
            dstSprite_LeftWing.physicsBody                      = SKPhysicsBody(rectangleOf: dstSprite_LeftWing.size)
            dstSprite_LeftWing.physicsBody?.isDynamic           = true
            dstSprite_LeftWing.physicsBody?.categoryBitMask     = playerCollisionCat
            dstSprite_LeftWing.physicsBody?.contactTestBitMask  = asteroidCollisionCat
            dstSprite_LeftWing.physicsBody?.collisionBitMask    = asteroidCollisionCat
            dstSprite_LeftWing.physicsBody!.allowsRotation      = true
            dstSprite_LeftWing.physicsBody?.mass                = 0.12
        
            dstSprite_RightWing.name                            = "ShipPart"
            dstSprite_RightWing.texture                         = SKTexture(imageNamed: "Ship_rightWing")
            dstSprite_RightWing.size.width                      = 12
            dstSprite_RightWing.size.height                     = 40
            dstSprite_RightWing.position                        = CGPoint(x: 14, y: 0)
            dstSprite_RightWing.physicsBody                     = SKPhysicsBody(rectangleOf: dstSprite_RightWing.size)
            dstSprite_RightWing.physicsBody?.isDynamic          = true
            dstSprite_RightWing.physicsBody?.categoryBitMask    = playerCollisionCat
            dstSprite_RightWing.physicsBody?.contactTestBitMask = asteroidCollisionCat
            dstSprite_RightWing.physicsBody?.collisionBitMask   = asteroidCollisionCat
            dstSprite_RightWing.physicsBody!.allowsRotation     = true
            dstSprite_RightWing.physicsBody?.mass               = 0.08
            
            dstSprite_FrontBody.name                            = "ShipPart"
            dstSprite_FrontBody.texture                         = SKTexture(imageNamed: "Ship_bodyFront")
            dstSprite_FrontBody.size.width                      = 10
            dstSprite_FrontBody.size.height                     = 14
            dstSprite_FrontBody.position                        = CGPoint(x: 0, y: 12)
            dstSprite_FrontBody.physicsBody                     = SKPhysicsBody(rectangleOf: dstSprite_FrontBody.size)
            dstSprite_FrontBody.physicsBody?.isDynamic          = true
            dstSprite_FrontBody.physicsBody?.categoryBitMask    = playerCollisionCat
            dstSprite_FrontBody.physicsBody?.contactTestBitMask = asteroidCollisionCat
            dstSprite_FrontBody.physicsBody?.collisionBitMask   = asteroidCollisionCat
            dstSprite_FrontBody.physicsBody!.allowsRotation     = true
            dstSprite_FrontBody.physicsBody?.mass               = 0.2
            
            dstSprite_BackBody.name                             = "ShipPart"
            dstSprite_BackBody.texture                          = SKTexture(imageNamed: "Ship_bodyBack")
            dstSprite_BackBody.size.width                       = 20
            dstSprite_BackBody.size.height                      = 20
            dstSprite_BackBody.position                         = CGPoint(x: 0, y: -8)
            dstSprite_BackBody.physicsBody                      = SKPhysicsBody(rectangleOf: dstSprite_BackBody.size)
            dstSprite_BackBody.physicsBody?.isDynamic           = true
            dstSprite_BackBody.physicsBody?.categoryBitMask     = playerCollisionCat
            dstSprite_BackBody.physicsBody?.contactTestBitMask  = asteroidCollisionCat
            dstSprite_BackBody.physicsBody?.collisionBitMask    = asteroidCollisionCat
            dstSprite_BackBody.physicsBody!.allowsRotation      = true
            dstSprite_BackBody.physicsBody?.mass                = 0.2
            
            /* * * * * * * * * * * *
             *  Gameplay stuff
             * * * * * * * * * * * */
            // Give Name, Position
            sprite.name                                         = name
            sprite.position                                     = CGPoint(x: x , y: y)
            sprite.texture                                      = SKTexture(imageNamed: "Ship_1") // add spaceship texture to sprite
            sprite.size.width                                   = 42
            sprite.size.height                                  = 42
            
            // Give physics
            sprite.physicsBody                                  = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.isDynamic                       = true
            sprite.physicsBody?.categoryBitMask                 = playerCollisionCat
            sprite.physicsBody?.contactTestBitMask              = asteroidCollisionCat
            sprite.physicsBody?.collisionBitMask                = asteroidCollisionCat
            sprite.physicsBody!.affectedByGravity               = false
            sprite.physicsBody!.mass                            = 0.02
            sprite.physicsBody!.allowsRotation                  = false
            sprite.physicsBody!.usesPreciseCollisionDetection   = true
            sprite.physicsBody!.linearDamping                   = 3
            
            // Give Particle Effect
            explosionEffect?.name                               = String("explosion")
            explosionEffect?.position                           = CGPoint(x: 0, y: 0)
            explosionEffect?.numParticlesToEmit                 = 1024
            explosionEffect?.removeFromParent()
            
            thrusterEffect?.name                                = String("thruster")
            thrusterEffect?.position                            = CGPoint(x: 0, y: -1)
            thrusterEffect?.removeFromParent()
            sprite.addChild(thrusterEffect!)
            
            sprite.zPosition = -1


            
            return sprite
        }
        
        func update () {
            
            // compensate for vertical drift
            if (!exploding) {
                if (sprite.position.y < CGFloat(restingY - 10)) {
                    velocity.dy += 0.0075 * (sprite.position.y + CGFloat(restingY))
                } else if (sprite.position.y > CGFloat(restingY + 10)) {
                    velocity.dy -= 0.0075 * (sprite.position.y - CGFloat(restingY))
                }
            }
            
            // apply velocity
            sprite.position.x += velocity.dx
            sprite.position.y += velocity.dy
            
            // dampen
            velocity.dx = velocity.dx / 2
            velocity.dy = velocity.dy / 2
            
            // laser
            for laser in (lasers as NSArray as! [LaserBeam]) { laser.update() }
            cullLasers()
            
            // pieces dispursal
            if (exploding) {
                
                // apply velocity
                dstSprite_LeftWing.position.x  += leftWingVelocity.dx
                dstSprite_LeftWing.position.y  += leftWingVelocity.dy
                dstSprite_RightWing.position.x += rightWingVelocity.dx
                dstSprite_RightWing.position.y += rightWingVelocity.dy
                dstSprite_FrontBody.position.x += frontBodyVelocity.dx
                dstSprite_FrontBody.position.y += frontBodyVelocity.dy
                dstSprite_BackBody.position.x  += backBodyVelocity.dx
                dstSprite_BackBody.position.y  += backBodyVelocity.dy
                
                // dampen
                leftWingVelocity.dx  *= 0.98
                leftWingVelocity.dy  *= 0.98
                rightWingVelocity.dx *= 0.98
                rightWingVelocity.dy *= 0.98
                frontBodyVelocity.dx *= 0.98
                frontBodyVelocity.dy *= 0.98
                backBodyVelocity.dx  *= 0.98
                backBodyVelocity.dy  *= 0.98
                
                // keep parts moving forward
                leftWingVelocity.dy  += 0.04
                rightWingVelocity.dy += 0.04
                frontBodyVelocity.dy += 0.04
                backBodyVelocity.dy  += 0.04
            }
        
            colourChangeArray.removeAll()
        }
        
        func pickupHealth () {
            if      (health < HEALTH_MAX - 10) { health += 10 }
            else if (health > HEALTH_MAX - 10) { health = HEALTH_MAX }
        }
        
        func pickupAmmo () {
            ammo = AMMO_MAX
        }
        
        func pickupPoints () {
            for _ in 1...100 { score.increment() }
        }
        
        func give (points: Int) {
            for _ in 1...points { score.increment() }
        }
        
        func takeDamage () {
            if colourChangeArray.isEmpty {
                colourChangeArray.append(SKAction.colorize(with: UIColor.red, colorBlendFactor: 0.5, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: UIColor.clear, colorBlendFactor: 0, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: UIColor.red, colorBlendFactor: 0.5, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: UIColor.clear, colorBlendFactor: 0, duration: 0.1))
                sprite.run(SKAction.sequence(colourChangeArray))
            }
            
            if      (health <  2) { health = 0 }
            else if (health >= 2) { health -= 1; }
        }
        
        func fireLaser () {
            if (ammo > 0) {
                let beam = LaserBeam()
                lasers.add(beam)
                ammo -= 1
                sprite.parent?.addChild(beam.fire(o: CGVector(dx: sprite.position.x, dy: sprite.position.y)))
            }
        }
        
        func explode () {
            if (!exploding) {
                exploding = true
                
                // kill thrusters and explpode
                thrusterEffect?.removeFromParent()
                sprite.addChild(explosionEffect!)
                
                /**
                 * BREAK TO PIECES
                 */
                // turn normal sprite (kind of) invisible
                sprite.isHidden = true
                
                // show the pieces
                resetFragmentedPieces()
                sprite.parent?.addChild(dstSprite_LeftWing)
                sprite.parent?.addChild(dstSprite_RightWing)
                sprite.parent?.addChild(dstSprite_BackBody)
                sprite.parent?.addChild(dstSprite_FrontBody)
  
                dstSprite_LeftWing.physicsBody?.applyImpulse  (leftWingVelocity,  at: sprite.position)
                dstSprite_RightWing.physicsBody?.applyImpulse (rightWingVelocity, at: sprite.position)
                dstSprite_FrontBody.physicsBody?.applyImpulse (frontBodyVelocity, at: sprite.position)
                dstSprite_BackBody.physicsBody?.applyImpulse  (backBodyVelocity,  at: sprite.position)
            }
        }
        
        func cullLasers () {
            for laser in (lasers as NSArray as! [LaserBeam]) {
                if (laser.getPosition().dy > 1000) {
                    laser.cull()
                    lasers.remove(laser)
                }
            }
        }
        
        func clearLasers () {
            for laser in (lasers as NSArray as! [LaserBeam]) {
                laser.cull()
                lasers.remove(laser)
            }
        }
        
        func spin() {
            //sprite.physicsBody!.allowsRotation = true
        }
        
        //Check if we have been initially hit for vibration
        func isExploding() -> Bool {
            return exploding
        }
        
        private func resetFragmentedVelocities () {
            leftWingVelocity.dx  = -4
            leftWingVelocity.dy  = 1
            rightWingVelocity.dx = 4
            rightWingVelocity.dy = 1
            frontBodyVelocity.dx = 1
            frontBodyVelocity.dy = 4
            backBodyVelocity.dx  = -1
            backBodyVelocity.dy  = 4
        }
        
        private func resetFragmentedPieces () {
            dstSprite_LeftWing.position.x  = sprite.position.x - 16
            dstSprite_LeftWing.position.y  = sprite.position.y - 1
            dstSprite_RightWing.position.x = sprite.position.x + 16
            dstSprite_RightWing.position.y = sprite.position.y - 1
            dstSprite_FrontBody.position.x = sprite.position.x
            dstSprite_FrontBody.position.y = sprite.position.y + 10
            dstSprite_BackBody.position.x  = sprite.position.x
            dstSprite_BackBody.position.y  = sprite.position.y - 8
        }
    }
}
