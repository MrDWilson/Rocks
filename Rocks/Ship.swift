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
    
        let MAX_BODY                  = 7
        let MAX_WING                  = 7
    
        // COLOURS
        private var coreColour        = LaserColour.cyan
        private var bodyColour        = BodyColour.green
    
        // LEFT WING
        private let leftWing          = SKSpriteNode ()
        private var leftWingID        = CGFloat(0)
        private var leftWingVelocity  = CGVector     (dx: -4, dy: 1)
        
        // RIGHT WING
        private let rightWing         = SKSpriteNode ()
        private var rightWingID       = CGFloat(0)
        private var rightWingVelocity = CGVector     (dx: 4, dy: 1)
        
        // BODY
        private var bodyID            = CGFloat(0)
        private var bodyVelocity      = CGVector     (dx: 1, dy: 4)
        
        // CORE
        private let core              = SKShapeNode (circleOfRadius: 6.5)
        private var coreVelocity      = CGVector (dx: 1, dy: 4)
        
        // EFFECTS
        private let explosionEffect   = SKEmitterNode(fileNamed: "ExplosionParticle.sks")
        private var thrusterEffect    = SKEmitterNode(fileNamed: "ThrusterParticle_1.sks")
        private var colourChangeArray = [SKAction]()

        // admin
        public let metaWidth: CGFloat   = 28
        public let metaHeight: CGFloat  = 28
        private var exploding           = false
        private var disassembled        = false
        private var animationSpeed      = CGFloat(0.04);

        init (bID: Int, tID: Int, cID: Int) {
            super.init(texture: SKTexture(imageNamed: "body_" + String(describing: bodyID)), color: UIColor.white, size: CGSize(width: 24, height: 24))
            
            // META
            name                                = "player"
            position                            = CGPoint(x: 0 , y: 0)
            size.width                          = metaWidth * 1
            size.height                         = metaHeight * 1.2

            // LEFT WING
            leftWing.name                       = "ShipPart"
            leftWing.texture                    = SKTexture(imageNamed: "wing_" + String(describing: Int(leftWingID)))
            leftWing.size.width                 = metaWidth * 0.62
            leftWing.size.height                = metaHeight * 1.2
            leftWing.position                   = CGPoint(x: (metaWidth * 0.45) * -1, y: 0)
            leftWing.zPosition = -3
            
            // RIGHT WING
            rightWing.name                      = "ShipPart"
            rightWing.texture                   = SKTexture(imageNamed: "wing_" + String(describing: Int(rightWingID)))
            rightWing.xScale                    = rightWing.xScale * -1
            rightWing.size.width                = metaWidth * 0.62
            rightWing.size.height               = metaHeight * 1.2
            rightWing.position                  = CGPoint(x: (metaWidth * 0.45) * 1, y: 0)
            rightWing.zPosition                 = -3
            
            // CORE
            core.name                           = "ShipPart"
            core.zPosition                      = -4
            core.fillColor                      = LaserColour.cyan.toUIColor
            core.strokeColor                    = LaserColour.cyan.toUIColor
            
            // Give Particle Effects
            explosionEffect?.name               = String("explosion")
            explosionEffect?.position           = CGPoint(x: 0, y: 0)
            explosionEffect?.numParticlesToEmit = 64
            explosionEffect?.removeFromParent()
            explosionEffect?.resetSimulation()

            thrusterEffect                      = SKEmitterNode(fileNamed: "ThrusterParticle_" + String(describing: Int(5)) + ".sks")
            thrusterEffect?.name                = String("thruster")
            thrusterEffect?.position            = CGPoint(x: 0, y: -1)
            thrusterEffect?.removeFromParent()
            addChild(thrusterEffect!)
            
            addChild(leftWing)
            addChild(rightWing)
            addChild(core)
            
            colourize()

        }
        
        required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
        func serialize () -> Vector3D {
            //print("x: " + String(describing: Int(bodyID)))
            //print("y: " + String(describing: Int(thrusterID)))
            //print("z: " + String(describing: Int(colorID.rawValue)))
        
            return Vector3D(x: 0, y: 0, z: 0)
        }
    
        func update () {
            if (disassembled) {
                // wings
                if (rightWing.position.x < 60) { rightWing.position.x += (60 - rightWing.position.x) * animationSpeed}
                if (leftWing.position.x > -60) { leftWing.position.x -= (60 - fabs(leftWing.position.x)) * animationSpeed}
                
                // core
                if (core.position.y > -60) {
                    core.position.y -= (60 - fabs (core.position.y)) * animationSpeed
                    thrusterEffect?.position.y -= (60 - fabs (core.position.y)) * animationSpeed
                    //thrusterEffect?.emissionAngleRange = 360
                    thrusterEffect?.particleLifetime = 0.03
                    thrusterEffect?.particleLifetimeRange = 0.1
                }
                
                if (thrusterEffect!.emissionAngleRange < CGFloat(360.0)) { thrusterEffect?.emissionAngleRange += 0.1 }
            } else {
                // wings
                if (rightWing.position.x > 14) { rightWing.position.x -= (rightWing.position.x - 14) * animationSpeed}
                if (leftWing.position.x < -14) { leftWing.position.x += (fabs(leftWing.position.x) - 14) * animationSpeed}
                
                // core
                if (core.position.y < 0) {
                    core.position.y += (fabs(core.position.y)) * animationSpeed
                    thrusterEffect?.position.y += (fabs(core.position.y)) * animationSpeed
                    //thrusterEffect?.emissionAngleRange = 0
                    thrusterEffect?.particleScaleRange = 0
                    thrusterEffect?.particleLifetime = 0.5
                    thrusterEffect?.particleLifetimeRange = 3
                }
                
                if (thrusterEffect!.emissionAngleRange > CGFloat(0)) { thrusterEffect!.emissionAngleRange -= thrusterEffect!.emissionAngleRange * (animationSpeed*5)}
            }
    
            // pieces dispursal
            if (exploding) {
    
                // apply velocity
                leftWing.position.x  += leftWingVelocity.dx
                leftWing.position.y  += leftWingVelocity.dy
                rightWing.position.x += rightWingVelocity.dx
                rightWing.position.y += rightWingVelocity.dy
                position.x           += bodyVelocity.dx
                position.y           += bodyVelocity.dy
    
                // dampen
                leftWingVelocity.dx  *= 0.98
                leftWingVelocity.dy  *= 0.98
                rightWingVelocity.dx *= 0.98
                rightWingVelocity.dy *= 0.98
                bodyVelocity.dx      *= 0.98
                bodyVelocity.dy      *= 0.98
    
                // keep parts moving "forward"
                leftWingVelocity.dy  += 0.04
                rightWingVelocity.dy += 0.04
                bodyVelocity.dy      += 0.04
            }
            
            // pieces holding
            else {
               // physicsBody?.allowsRotation = true
               // zRotation = 0
               // physicsBody?.allowsRotation = false
               // leftWing.zRotation = 0
               // rightWing.zRotation = 0
            }
        }
    
        func colourize () {
            run           (SKAction.colorize(with: bodyColour.toUIColor, colorBlendFactor: 0.85, duration: 0))
            leftWing.run  (SKAction.colorize(with: bodyColour.toUIColor, colorBlendFactor: 0.85, duration: 0))
            rightWing.run (SKAction.colorize(with: bodyColour.toUIColor, colorBlendFactor: 0.85, duration: 0))
        }
        
        func refreshLeftWing  () { leftWing.texture  = SKTexture(imageNamed: String("wing_" + String(describing: Int(leftWingID)))) }
        func refreshRightWing () { rightWing.texture = SKTexture(imageNamed: String("wing_" + String(describing: Int(rightWingID)))) }
        func refreshBody      () { self.texture      = SKTexture(imageNamed: String("body_" + String(describing: Int(bodyID)))) }
        
        func refreshCore () {
            thrusterEffect?.particleColor = coreColour.toUIColor
            thrusterEffect?.resetSimulation()
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
            // show the pieces
            name = "ShipPart"
            
            leftWing.physicsBody                      = SKPhysicsBody(rectangleOf: leftWing.size)
            leftWing.physicsBody?.isDynamic           = true
            leftWing.physicsBody?.categoryBitMask     = playerCollisionCat
            leftWing.physicsBody?.contactTestBitMask  = asteroidCollisionCat
            leftWing.physicsBody?.collisionBitMask    = asteroidCollisionCat
            leftWing.physicsBody?.pinned = false
            leftWing.physicsBody?.allowsRotation = true
            
            rightWing.physicsBody                      = SKPhysicsBody(rectangleOf: leftWing.size)
            rightWing.physicsBody?.isDynamic           = true
            rightWing.physicsBody?.categoryBitMask     = playerCollisionCat
            rightWing.physicsBody?.contactTestBitMask  = asteroidCollisionCat
            leftWing.physicsBody?.collisionBitMask    = asteroidCollisionCat
            rightWing.physicsBody?.pinned = false
            rightWing.physicsBody?.allowsRotation = true
            
            //physicsBody?.allowsRotation = true
            
            leftWing.physicsBody?.applyImpulse  (leftWingVelocity,  at: position)
            rightWing.physicsBody?.applyImpulse (rightWingVelocity, at: position)
            physicsBody?.applyImpulse (bodyVelocity, at: position)
            //body.physicsBody?.applyImpulse (bodyVelocity, at: position)
        }
        
        func isExploding () -> Bool {
            return exploding
        }
    
        func reassemble () {
            exploding = false
            disassembled = false
        
            // remove colour
            colourChangeArray.removeAll()
            colourize()
        
            // reassemble pieces
            name = "player"
            
            leftWing.size.width                       = metaWidth * 0.5
            leftWing.size.height                      = metaHeight
            leftWing.position                         = CGPoint(x: -14, y: 0)
            leftWing.zPosition                        = -3
            leftWing.zRotation                        = 0
            leftWing.physicsBody!.allowsRotation      = false
            leftWing.physicsBody?.pinned              = true
            leftWing.physicsBody = nil
            
            rightWing.size.width                      = metaWidth * 0.5
            rightWing.size.height                     = metaHeight
            rightWing.position                        = CGPoint(x: 14, y: 0)
            rightWing.zPosition                       = -3
            rightWing.zRotation                       = 0
            rightWing.physicsBody?.allowsRotation     = false
            rightWing.physicsBody?.pinned             = true
            rightWing.physicsBody = nil
            
            physicsBody?.allowsRotation = false
            zRotation = 0
    
            resetFragmentedVelocities()
            
            // kill explosion and start thrust
            explosionEffect?.removeFromParent () // delete particle effec
            
            addChild(thrusterEffect!)
        }
        
        func flash(color: UIColor) {
            if colourChangeArray.isEmpty {
                colourChangeArray.append(SKAction.colorize(with: color, colorBlendFactor: 0.75, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: bodyColour.toUIColor, colorBlendFactor: 1, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: color, colorBlendFactor: 0.75, duration: 0.1))
                colourChangeArray.append(SKAction.wait(forDuration: 0.1))
                colourChangeArray.append(SKAction.colorize(with: bodyColour.toUIColor, colorBlendFactor: 1, duration: 0.1))
                run(SKAction.sequence(colourChangeArray))
            }
        }
        
        func disassemble        () { disassembled = true }
        func animatedReassemble () { disassembled = false }
        
        /* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
         *  Custom Ship
         *
         * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
        
        /* *
         *  paint colour
         */
        func nextColour () { bodyColour = bodyColour.nextColour; colourize () }
        func prevColour () { bodyColour = bodyColour.prevColour; colourize () }
        
        /* *
         *  left wing
         */
        func nextLeftWing  () { leftWingID = CGFloat(Int(leftWingID + 1) % MAX_WING); refreshLeftWing () }
        func prevLefttWing () { if (leftWingID == 0) { leftWingID = CGFloat(MAX_WING) } else { leftWingID -= 1 }; refreshLeftWing () }
        
        /* *
         *  right wing
         */
        func nextRightWing () { rightWingID = CGFloat(Int(rightWingID + 1) % MAX_WING); refreshRightWing () }
        func prevRightWing () { if (rightWingID == 0) { rightWingID = CGFloat(MAX_WING) } else { rightWingID -= 1 }; refreshRightWing () }
        
        /* *
         *  body
         */
        func nextBody () { bodyID = CGFloat(Int(bodyID + 1) % MAX_BODY); refreshBody () }
        func prevBody () { if (bodyID == 0) { bodyID = CGFloat(MAX_BODY) } else { bodyID -= 1 }; refreshBody () }
        
        /* *
         *  core/laser/thruster colour
         */
        func nextCore () { coreColour = coreColour.nextColour; refreshCore () }
        func prevCore () { coreColour = coreColour.prevColour; refreshCore () }
    
        /** 
         *  disassembley recovery
         */
        private func resetFragmentedVelocities () {
            leftWingVelocity.dx  = -4
            leftWingVelocity.dy  = 1
            rightWingVelocity.dx = 4
            rightWingVelocity.dy = 1
            bodyVelocity.dx      = 1
            bodyVelocity.dy      = 4
        }
    
        private func resetFragmentedPieces () {
            leftWing.position.x  = position.x - 16
            leftWing.position.y  = position.y - 1
            rightWing.position.x = position.x + 16
            rightWing.position.y = position.y - 1
        }
    }
}
