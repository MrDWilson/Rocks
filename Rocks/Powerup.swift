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
            case PointsPickup_25
            case PointsPickup_50
            case PointsPickup_100
        }
    
        private let sprite            = SKSpriteNode(color: UIColor.red, size: CGSize(width: 15, height: 15))
        private let velocity:CGVector = CGVector(dx: 0, dy: 0 - 4)
        private var xConfine:Int      = 1080
        private var yConfine:Int      = 1920 // 6 plus default
        private var player: Player!
        
        private var textureCache: TextureCache!
        
        func setXConfine (con: Int) { xConfine = con - Int(sprite.size.width) }
        func setYConfine (con: Int) { yConfine = con + Int(sprite.size.width) }
        
        private var type    = PowerupType.PointsPickup_25 // default to points powerup

        func generateType () {
            // decide type
            let ting = arc4random_uniform(5)
            switch ting {
                case 0:
                    sprite.name = "HealthPickup"
                    type = .HealthPickup
                    sprite.texture = textureCache.getCached(key: "HealthPickup")
                    sprite.run(SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0))
                    break
                case 1:
                    sprite.name = "AmmoPickup"
                    type = .AmmoPickup
                    sprite.texture = textureCache.getCached(key: "AmmoPickup")
                    sprite.run(SKAction.colorize(with: UIColor.cyan, colorBlendFactor: 1.0, duration: 0))
                    break
                case 2:
                    sprite.name = "PointsPickup_25"
                    type = .PointsPickup_25
                    sprite.texture = textureCache.getCached(key: "PointsPickup_1")
                    sprite.run(SKAction.colorize(with: UIColor.gray, colorBlendFactor: 1.0, duration: 0))
                    break
                case 3:
                    sprite.name = "PointsPickup_50"
                    type = .PointsPickup_50
                    sprite.texture = textureCache.getCached(key: "PointsPickup_2")
                    sprite.run(SKAction.colorize(with: UIColor.lightGray, colorBlendFactor: 1.0, duration: 0))
                    break
                case 4:
                    sprite.name = "PointsPickup_100"
                    type = .PointsPickup_100
                    sprite.texture = textureCache.getCached(key: "PointsPickup_3")
                    sprite.run(SKAction.colorize(with: UIColor.white, colorBlendFactor: 1.0, duration: 0))
                    break
                default:
                    break
            }
            
            if (type == PowerupType.AmmoPickup) {
                sprite.run(SKAction.colorize(with: player.getLaserColour(), colorBlendFactor: 1, duration: 0))
            }
        }
        
        func spawn (textureCache: TextureCache, player: Player) -> SKSpriteNode {
            self.textureCache = textureCache
            
            self.player = player
            
            generateType()
            
            // Give position
            sprite.position.x = CGFloat(arc4random_uniform(UInt32(xConfine)))
            sprite.position.y = CGFloat(yConfine + 1000 + Int(arc4random_uniform(1024)))
            
            sprite.size.width = 20
            sprite.size.height = 20
            
            // Give physics components
            sprite.physicsBody?.isDynamic = true
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.categoryBitMask = powerupCollisionCat
            sprite.physicsBody?.contactTestBitMask = playerCollisionCat
            sprite.physicsBody?.collisionBitMask = playerCollisionCat
            sprite.physicsBody?.mass = 0.0000001
            
            sprite.physicsBody?.density = 0.0000001 // fix hitting powerups side on
            
            sprite.zPosition = -2
            
            // add to scene
            return sprite
        }
        
        func update () {
            sprite.position.x += velocity.dx
            sprite.position.y += velocity.dy
            
//          print("x: " + String(describing: sprite.position.x))
//          print("y: " + String(describing: sprite.position.y))
            
            if (sprite.position.y < 0 - sprite.size.height) {
                reuse()
            }
            
            sprite.physicsBody?.allContactedBodies().forEach {
                if ($0.node?.name == "player") {
                    collected()
                }
            }
            
            if (type == PowerupType.AmmoPickup) {
                sprite.run(SKAction.colorize(with: player.getLaserColour(), colorBlendFactor: 1, duration: 0))
            }
        }
        
        func collected () {
            reuse()
        }
        
        private func reuse () {
            // regenerate
            generateType()
            
            // reuse
            sprite.position.x = CGFloat(arc4random_uniform(UInt32(xConfine)))
            sprite.position.y = CGFloat(yConfine + 1000 + Int(arc4random_uniform(1024)))
        }
    }
}
