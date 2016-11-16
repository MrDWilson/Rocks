/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  Ship.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class Ship: SKSpriteNode {
        
        private let dstSprite_LeftWing  = SKSpriteNode ()
        private var leftWingVelocity    = CGVector     (dx: -4, dy: 1)
        private let dstSprite_RightWing = SKSpriteNode ()
        private var rightWingVelocity   = CGVector     (dx: 4, dy: 1)
        private let dstSprite_FrontBody = SKSpriteNode ()
        private var frontBodyVelocity   = CGVector     (dx: 1, dy: 4)
        private let dstSprite_BackBody  = SKSpriteNode ()
        private var backBodyVelocity    = CGVector     (dx: -1, dy: 4)
        private let explosionEffect     = SKEmitterNode(fileNamed: "ExplosionParticle.sks")
        private var thrusterEffect      = SKEmitterNode(fileNamed: "ThrusterParticle_" + String(describing: (1 + arc4random_uniform(7))) + ".sks")
        private var colourChangeArray   = [SKAction]()
        
        // admin
        private var bodyID: Int!
        private var thrusterID: Int!
        private var colorID: UIColor!
        private var exploding = false
        
        init (bID: Int, tID: Int, cID: UIColor) {
            super.init(texture: SKTexture(imageNamed: "Ship_" + String(describing: bID)), color: cID, size: CGSize(width: 24, height: 24))
            
            bodyID = bID
            thrusterID = tID
            colorID = cID
            
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
            dstSprite_LeftWing.run(SKAction.colorize(with: colorID, colorBlendFactor: 0.85, duration: 0))
            
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
            dstSprite_RightWing.run(SKAction.colorize(with: colorID, colorBlendFactor: 0.85, duration: 0))
            
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
            dstSprite_FrontBody.run(SKAction.colorize(with: colorID, colorBlendFactor: 0.85, duration: 0))
            
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
            dstSprite_BackBody.run(SKAction.colorize(with: colorID, colorBlendFactor: 0.85, duration: 0))
            
            /* * * * * * * * * * * *
             *  Gameplay stuff
             * * * * * * * * * * * */
            // Give Name, Position
            name                                         = "player"
            position                                     = CGPoint(x: 0 , y: 0)
            texture                                      = SKTexture(imageNamed: "Ship_1") // add spaceship texture to sprite
            size.width                                   = 42
            size.height                                  = 42
            
            // Give physics
            physicsBody                                  = SKPhysicsBody(rectangleOf: size)
            physicsBody?.isDynamic                       = true
            physicsBody?.categoryBitMask                 = playerCollisionCat
            physicsBody?.contactTestBitMask              = asteroidCollisionCat
            physicsBody?.collisionBitMask                = asteroidCollisionCat
            physicsBody!.affectedByGravity               = false
            physicsBody!.mass                            = 0.02
            physicsBody!.allowsRotation                  = false
            physicsBody!.usesPreciseCollisionDetection   = true
            physicsBody!.linearDamping                   = 3
            
            // Give Particle Effect
            explosionEffect?.name                               = String("explosion")
            explosionEffect?.position                           = CGPoint(x: 0, y: 0)
            explosionEffect?.numParticlesToEmit                 = 1024
            explosionEffect?.removeFromParent()
            
            thrusterEffect?.name                                = String("thruster")
            thrusterEffect?.position                            = CGPoint(x: 0, y: -1)
            thrusterEffect?.removeFromParent()
            addChild(thrusterEffect!)
            
            run(SKAction.colorize(with: colorID, colorBlendFactor: 0.85, duration: 0))
            
        }
        
        required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
        
        func update () {
            
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
        }
        
        func explode () {
            exploding = true
            
            // kill thrusters and explpode
            thrusterEffect?.removeFromParent()
            addChild(explosionEffect!)
            
            /**
             * BREAK TO PIECES
             */
            // turn normal sprite (kind of) invisible
            isHidden = true
            
            // show the pieces
            resetFragmentedPieces()
            parent?.addChild(dstSprite_LeftWing)
            parent?.addChild(dstSprite_RightWing)
            parent?.addChild(dstSprite_BackBody)
            parent?.addChild(dstSprite_FrontBody)
            
            dstSprite_LeftWing.physicsBody?.applyImpulse  (leftWingVelocity,  at: position)
            dstSprite_RightWing.physicsBody?.applyImpulse (rightWingVelocity, at: position)
            dstSprite_FrontBody.physicsBody?.applyImpulse (frontBodyVelocity, at: position)
            dstSprite_BackBody.physicsBody?.applyImpulse  (backBodyVelocity,  at: position)
        }
        
        func isExploding () -> Bool {
            return exploding
        }
        
        func reassemble () {
            
            // remove colour
            colourChangeArray.removeAll()
            run(SKAction.colorize(with: colorID, colorBlendFactor: 0.85, duration: 0))
            
            // reassemble pieces
            dstSprite_LeftWing.removeFromParent  ()
            dstSprite_RightWing.removeFromParent ()
            dstSprite_FrontBody.removeFromParent ()
            dstSprite_BackBody.removeFromParent  ()
            
            resetFragmentedVelocities()
            
            // kill explosion and start thrust
            explosionEffect?.removeFromParent () // delete particle effec
            explosionEffect?.resetSimulation  ()
            // randomise thruster (CACHE THESE?)
            thrusterEffect = SKEmitterNode(fileNamed: "ThrusterParticle_" + String(describing: (1 + arc4random_uniform(7))) + ".sks")
            addChild(thrusterEffect!)
            
            isHidden = false
        }
        
        func flash(color: UIColor) {
            if colourChangeArray.isEmpty {
                colourChangeArray.append(SKAction.colorize(with: color, colorBlendFactor: 0.75, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: colorID, colorBlendFactor: 0.85, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: color, colorBlendFactor: 0.75, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: colorID, colorBlendFactor: 0.85, duration: 0.1))
                run(SKAction.sequence(colourChangeArray))
            }
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
            dstSprite_LeftWing.position.x  = position.x - 16
            dstSprite_LeftWing.position.y  = position.y - 1
            dstSprite_RightWing.position.x = position.x + 16
            dstSprite_RightWing.position.y = position.y - 1
            dstSprite_FrontBody.position.x = position.x
            dstSprite_FrontBody.position.y = position.y + 10
            dstSprite_BackBody.position.x  = position.x
            dstSprite_BackBody.position.y  = position.y - 8
        }
    }
}
