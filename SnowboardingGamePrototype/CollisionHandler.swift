/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  CollisionHandler.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit
import AudioToolbox

// Collision Bit Mask
struct collision {
    static let player:UInt32 = 0x00
    static let asteroid:UInt32 = 0x01
    static let laserbeam:UInt32 = 0x02
    static let powerup:UInt32 = 0x03
}


extension GameScene {
    // On-Collision
    func didBegin(_ contact: SKPhysicsContact) {
        
        // LASER HITS ASTEROID
        if (contact.bodyA.node?.name == "laserbeam" && contact.bodyB.node?.name == "asteroid" ) {
            contact.bodyA.node?.run(SKAction.removeFromParent())
            contact.bodyB.node?.run(SKAction.removeFromParent())
        }
        if (contact.bodyA.node?.name == "asteroid" && contact.bodyB.node?.name == "laserbeam" ) {
            contact.bodyA.node?.run(SKAction.removeFromParent())
            contact.bodyB.node?.run(SKAction.removeFromParent())
        }
        
        // PLAYER HITS ASTEROID
        if (contact.bodyA.node?.name == "PlayerOne" && contact.bodyB.node?.name == "asteroid" ) ||
           (contact.bodyB.node?.name == "PlayerOne" && contact.bodyA.node?.name == "asteroid" ) {
            if (player.getHealth() == 0) {
                // bzzz
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                player.spin()
                player.explode()
                player.clearLasers()
                
                hud.gameEnded()
                hud.update(state: isPaused, score: player.getScore()) // HUD needs to be updated before a pause
                playing  = false
                
                // save high scores
                if(player.getScore() > save.getHighScore()) {
                    save.setHighScore(x: player.getScore())
                    save.saveToiCloud()
                }
            
            }
           
            else {
                player.takeDamage()
            }

        }
        
        // PLAYER HITS HEALTH PICKUP
        if (contact.bodyA.node?.name == "PlayerOne" && contact.bodyB.node?.name == "HealthPickup" ) {
            contact.bodyB.node?.run(SKAction.removeFromParent())
            player.pickupHealth()
        }
        
        if (contact.bodyA.node?.name == "HealthPickup" && contact.bodyB.node?.name == "PlayerOne" ) {
            contact.bodyA.node?.run(SKAction.removeFromParent())
            player.pickupHealth()
        }
        
        // PLAYER HITS AMMO PICKUP
        if (contact.bodyA.node?.name == "PlayerOne" && contact.bodyB.node?.name == "AmmoPickup" ) {
            contact.bodyB.node?.run(SKAction.removeFromParent())
            player.pickupAmmo()
        }
        
        if (contact.bodyA.node?.name == "AmmoPickup" && contact.bodyB.node?.name == "PlayerOne" ) {
            contact.bodyA.node?.run(SKAction.removeFromParent())
            player.pickupAmmo()
        }
        
        // PLAYER HITS POINTS PICKUP
        if (contact.bodyA.node?.name == "PlayerOne" && contact.bodyB.node?.name == "PointsPickup" ) {
            contact.bodyB.node?.run(SKAction.removeFromParent())
            player.give(points: 10)
        }
        
        if (contact.bodyA.node?.name == "PointsPickup" && contact.bodyB.node?.name == "PlayerOne" ) {
            contact.bodyA.node?.run(SKAction.removeFromParent())
            player.give(points: 10)
        }
    }
}
