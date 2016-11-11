/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  Powerup.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class Powerup {
        private enum PowerupType {
            case HealthPickup
            case AmmoPickup
            case PointsPickup
        }
    
        private let sprite  = SKSpriteNode(color: UIColor.red, size: CGSize(width: 15, height: 15))
        private var actions = [SKAction]()
        private let speed   = 5
        private var type    = PowerupType.PointsPickup // default to points powerup
        
        func spawn (x: Int, y: Int) -> SKSpriteNode {
            
            // Give name, size and position
            sprite.position = CGPoint(x: x, y: y)
    
            // decide type
            let ting = arc4random_uniform(3)
            switch ting {
                case 0:
                    sprite.name = "HealthPickup"
                    type = .HealthPickup
                    sprite.texture = SKTexture(imageNamed: "HealthPickup")
                    let changeColorAction = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0)
                    sprite.run(changeColorAction)
                    break
                case 1:
                    sprite.name = "AmmoPickup"
                    type = .AmmoPickup
                    sprite.texture = SKTexture(imageNamed: "AmmoPickup")
                    let changeColorAction = SKAction.colorize(with: UIColor.cyan, colorBlendFactor: 1.0, duration: 0)
                    sprite.run(changeColorAction)
                    break
                case 2:
                    sprite.name = "PointsPickup"
                    type = .PointsPickup
                    sprite.texture = SKTexture(imageNamed: "PointsPickup")
                    break
                default:
                    break
            }
            
            
            sprite.size.width = 20
            sprite.size.height = 20
            
            // Give physics components
            sprite.physicsBody?.isDynamic = true
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.categoryBitMask = collision.powerup
            sprite.physicsBody?.collisionBitMask = collision.player
            sprite.physicsBody?.contactTestBitMask = collision.powerup
            sprite.physicsBody?.density = 0.001 // fix hitting powerups side on
            
            // Give motion
            //actionArray.append(SKAction.rotate(byAngle: 360, duration: TimeInterval(spin)))
            actions.append (SKAction.move(to: CGPoint(x: sprite.position.x, y: -sprite.size.height), duration: TimeInterval(speed)))
            actions.append (SKAction.removeFromParent()); // ISSUE: Asteroids aren't removing themselves to be garbage collected
            sprite.run     (SKAction.sequence(actions))
            
            sprite.zPosition = -2
            
            // add to scene
            return sprite
        }
    }
}
