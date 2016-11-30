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
        private let leftWing          = SKSpriteNode ()
        private var leftWingVelocity  = CGVector     (dx: -4, dy: 1)
        private let rightWing         = SKSpriteNode ()
        private var rightWingVelocity = CGVector     (dx: 4, dy: 1)
        private let body         = SKSpriteNode ()
        private var bodyVelocity = CGVector     (dx: 1, dy: 4)
        private let explosionEffect   = SKEmitterNode(fileNamed: "ExplosionParticle.sks")
        private var thrusterEffect    = SKEmitterNode(fileNamed: "ThrusterParticle_1.sks")
        private var colourChangeArray = [SKAction]()

        // admin
        private var bodyID:     Int!
        private var thrusterID: Int!
        private var colorID:    REColour!
        private var exploding   = false

        init (bID: Int, tID: Int, cID: Int) {
            super.init(texture: SKTexture(imageNamed: "Ship_" + String(describing: bID)), color: UIColor.white, size: CGSize(width: 24, height: 24))
            
            bodyID = bID
            thrusterID = tID
            colorID = REColour(rawValue: cID)
            
            /* * * * * * * * * * * *
             *  Gameplay stuff
             * * * * * * * * * * * */
            // Give Name, Position
            name                                         = "player"
            position                                     = CGPoint(x: 0 , y: 0)
            //   texture                                      = SKTexture(imageNamed: "Ship_1") // add spaceship texture to sprite
            size.width                                   = 42
            size.height                                  = 42
            
            /* * * * * * * * * * * *
             *  Destruction Stuff
             * * * * * * * * * * * */
            leftWing.name                             = "ShipPart"
            leftWing.texture                          = SKTexture(imageNamed: "Ship_" + String(describing: Int(bodyID)) + "_leftWing")
            leftWing.size.width                       = size.width / 2
            leftWing.size.height                      = size.height / 1.15
            leftWing.position                         = CGPoint(x: -14, y: 0)
            leftWing.physicsBody                      = SKPhysicsBody(rectangleOf: leftWing.size)
            leftWing.physicsBody?.isDynamic           = true
            leftWing.physicsBody?.categoryBitMask     = playerCollisionCat
            leftWing.physicsBody?.contactTestBitMask  = asteroidCollisionCat
            leftWing.physicsBody?.collisionBitMask    = asteroidCollisionCat
            leftWing.physicsBody!.allowsRotation      = true
            leftWing.physicsBody?.mass                = 0.12
            
            rightWing.name                            = "ShipPart"
            rightWing.texture                         = SKTexture(imageNamed: "Ship_" + String(describing: Int(bodyID)) + "_rightWing")
            rightWing.size.width                      = size.width / 2
            rightWing.size.height                     = size.height / 1.15
            rightWing.position                        = CGPoint(x: 14, y: 0)
            rightWing.physicsBody                     = SKPhysicsBody(rectangleOf: rightWing.size)
            rightWing.physicsBody?.isDynamic          = true
            rightWing.physicsBody?.categoryBitMask    = playerCollisionCat
            rightWing.physicsBody?.contactTestBitMask = asteroidCollisionCat
            rightWing.physicsBody?.collisionBitMask   = asteroidCollisionCat
            rightWing.physicsBody!.allowsRotation     = true
            rightWing.physicsBody?.mass               = 0.08
            
            body.name                            = "ShipPart"
            body.texture                         = SKTexture(imageNamed: "Ship_" + String(describing: Int(bodyID)) + "_body")
            body.size.width                      = size.width / 2
            body.size.height                     = size.height / 1.25
            body.position                        = CGPoint(x: 0, y: 12)
            body.physicsBody                     = SKPhysicsBody(rectangleOf: body.size)
            body.physicsBody?.isDynamic          = true
            body.physicsBody?.categoryBitMask    = playerCollisionCat
            body.physicsBody?.contactTestBitMask = asteroidCollisionCat
            body.physicsBody?.collisionBitMask   = asteroidCollisionCat
            body.physicsBody!.allowsRotation     = true
            body.physicsBody?.mass               = 0.2
            
            // Give Particle Effect
            explosionEffect?.name                               = String("explosion")
            explosionEffect?.position                           = CGPoint(x: 0, y: 0)
            explosionEffect?.numParticlesToEmit                 = 64
            explosionEffect?.removeFromParent()
            explosionEffect?.resetSimulation()
            
            thrusterEffect = SKEmitterNode(fileNamed: "ThrusterParticle_" + String(describing: Int(thrusterID)) + ".sks")
            thrusterEffect?.name                                = String("thruster")
            thrusterEffect?.position                            = CGPoint(x: 0, y: -1)
            thrusterEffect?.removeFromParent()
            addChild(thrusterEffect!)
            
            colourize()

        }
        
        required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
        func serialize () -> Vector3D {
            print("x: " + String(describing: Int(bodyID)))
            print("y: " + String(describing: Int(thrusterID)))
            print("z: " + String(describing: Int(colorID.rawValue)))
        
            return Vector3D(x: bodyID, y: thrusterID, z: colorID.rawValue)
        }
    
        func update () {
    
            // pieces dispursal
            if (exploding) {
    
                // apply velocity
                leftWing.position.x  += leftWingVelocity.dx
                leftWing.position.y  += leftWingVelocity.dy
                rightWing.position.x += rightWingVelocity.dx
                rightWing.position.y += rightWingVelocity.dy
                body.position.x += bodyVelocity.dx
                body.position.y += bodyVelocity.dy
    
                // dampen
                leftWingVelocity.dx  *= 0.98
                leftWingVelocity.dy  *= 0.98
                rightWingVelocity.dx *= 0.98
                rightWingVelocity.dy *= 0.98
                bodyVelocity.dx *= 0.98
                bodyVelocity.dy *= 0.98
    
                // keep parts moving forward
                leftWingVelocity.dy  += 0.04
                rightWingVelocity.dy += 0.04
                bodyVelocity.dy += 0.04
            }
        }
    
        func colourize () {
            run           (SKAction.colorize(with: colorID.toUIColor, colorBlendFactor: 0.85, duration: 0))
            leftWing.run  (SKAction.colorize(with: colorID.toUIColor, colorBlendFactor: 0.85, duration: 0))
            rightWing.run (SKAction.colorize(with: colorID.toUIColor, colorBlendFactor: 0.85, duration: 0))
            body.run (SKAction.colorize(with: colorID.toUIColor, colorBlendFactor: 0.85, duration: 0))
        }
        
        func refreshThruster () {
            thrusterEffect?.removeFromParent()
            thrusterEffect = SKEmitterNode(fileNamed: "ThrusterParticle_" + String(thrusterID) + ".sks")
            addChild(thrusterEffect!)
        }
        
        func refreshBody () {
            texture = SKTexture(imageNamed: String("Ship_" + String(describing: Int(bodyID))))
            leftWing.texture = SKTexture(imageNamed: "Ship_" + String(describing: Int(bodyID)) + "_leftWing")
            rightWing.texture = SKTexture(imageNamed: "Ship_" + String(describing: Int(bodyID)) + "_rightWing")
            body.texture = SKTexture(imageNamed: "Ship_" + String(describing: Int(bodyID)) + "_body")
        }
    
        func explode () {
            exploding = true
            
            // kill thrusters and explpode
            thrusterEffect?.removeFromParent()
            explosionEffect?.resetSimulation()
            explosionEffect?.position = position
            parent?.addChild(explosionEffect!)
            
            /**
             * BREAK TO PIECES
             */
            // turn normal sprite (kind of) invisible
            isHidden = true
            
            // show the pieces
            resetFragmentedPieces()
            parent?.addChild(leftWing)
            parent?.addChild(rightWing)
            parent?.addChild(body)
            
            leftWing.physicsBody?.applyImpulse  (leftWingVelocity,  at: position)
            rightWing.physicsBody?.applyImpulse (rightWingVelocity, at: position)
            body.physicsBody?.applyImpulse (bodyVelocity, at: position)
        }
        
        func isExploding () -> Bool {
            return exploding
        }
    
        func reassemble () {
        
            // remove colour
            colourChangeArray.removeAll()
            colourize()
        
            // reassemble pieces
            leftWing.removeFromParent  ()
            rightWing.removeFromParent ()
            body.removeFromParent ()
    
            resetFragmentedVelocities()
            
            // kill explosion and start thrust
            explosionEffect?.removeFromParent () // delete particle effec
            
            // randomise thruster (CACHE THESE?)
            //thrusterEffect = SKEmitterNode(fileNamed: "ThrusterParticle_" + thrusterID + ".sks")
            addChild(thrusterEffect!)
    
            isHidden = false
        }
        
        func flash(color: UIColor) {
            if colourChangeArray.isEmpty {
                colourChangeArray.append(SKAction.colorize(with: color, colorBlendFactor: 0.75, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: colorID.toUIColor, colorBlendFactor: 1, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: color, colorBlendFactor: 0.75, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: colorID.toUIColor, colorBlendFactor: 1, duration: 0.1))
                run(SKAction.sequence(colourChangeArray))
            }
        }
        
        func nextColour () {
            colorID = colorID.nextColour
            
            if (colorID.rawValue == 0) {
                bodyID = 10 + ((bodyID + 1) % 3)
                refreshBody()
            }
            colourize()
        }
        
        func prevColour () {
            colorID = colorID.prevColour
            
            if (colorID.rawValue == 0) {
                if (bodyID == 10) {
                    bodyID = 12
                } else {
                    bodyID = bodyID - 1
                }
                refreshBody()
            }
            
            colourize()
        }
        
        func nextThruster () {
            thrusterID = ((thrusterID + 1) % 6)
            print (thrusterID)
            refreshThruster()
        }
        
        func prevThruster () {
            if (thrusterID == 0) {
                thrusterID = 6
            } else {
                thrusterID = thrusterID - 1
            }
            refreshThruster()
        }
    
        private func resetFragmentedVelocities () {
            leftWingVelocity.dx  = -4
            leftWingVelocity.dy  = 1
            rightWingVelocity.dx = 4
            rightWingVelocity.dy = 1
            bodyVelocity.dx = 1
            bodyVelocity.dy = 4
        }
    
        private func resetFragmentedPieces () {
            leftWing.position.x  = position.x - 16
            leftWing.position.y  = position.y - 1
            rightWing.position.x = position.x + 16
            rightWing.position.y = position.y - 1
            body.position.x = position.x
            body.position.y = position.y + 10
        }
    }
}
