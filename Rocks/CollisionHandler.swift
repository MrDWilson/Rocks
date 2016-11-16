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

let playerCollisionCat:     UInt32 = 0x00
let asteroidCollisionCat:   UInt32 = 0x01
let laserbeamCollisionCat:  UInt32 = 0x02
let powerupCollisionCat:    UInt32 = 0x03

extension GameScene {
    
//    Saver test - leaderboard
    
    // On-Collision
    func didBegin(_ contact: SKPhysicsContact) {
        
        if (contact.bodyA.node?.name == "asteroid" && contact.bodyB.node?.name == "asteroid" ) {
          //  contact.bodyA.applyForce(CGVector(dx: 10, dy: 10))
          //  contact.bodyB.applyForce(CGVector(dx: -10, dy: 10))
        }
        
        // LASER HITS ASTEROID
        if (contact.bodyA.node?.name == "laserbeam" && contact.bodyB.node?.name == "asteroid" ) {
           // contact.bodyA.node?.removeFromParent()
            player.give(points: 25)
            userInterface.flashScore()
        }
        if (contact.bodyA.node?.name == "asteroid" && contact.bodyB.node?.name == "laserbeam" ) {
           // contact.bodyB.node?.removeFromParent()
            player.give(points: 25)
            userInterface.flashScore()
        }
        
        // PLAYER HITS ASTEROID
        if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "asteroid" ) ||
           (contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "asteroid" ) {
            
            if (player.getHealth() == 1) && (state == .InGame) {
                state = .GameOver
                
                // bzzz
                if(!player.isExploding() && vibrate) {
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
                
                player.explode()
                player.clearLasers()
                userInterface.update(state: state)

                // save high scores
                if(player.getScore() > saver.getHighScore()) {
                    saver.setHighScore(x: player.getScore())
                    saver.saveToiCloud()
                    //High score saves to leaderboard
                    leaderboard.updateScore(score: player.getScore())
                    leaderboard.loads()
                    print(leaderboard.getEntries().count)
                }
            }
           
            else {
                var normalReverse = contact.contactNormal
                
                normalReverse.dx = normalReverse.dx - (normalReverse.dx * 2)
                normalReverse.dy = normalReverse.dy - (normalReverse.dy * 2)
                
                if (contact.bodyA.node?.name == "player") {
                    contact.bodyA.applyImpulse(contact.contactNormal, at: contact.contactPoint)
                } else {
                    contact.bodyB.applyImpulse(contact.contactNormal, at: contact.contactPoint)
                }
            
                player.takeDamage()
            }    
            //*/
        }
        
        // SHIP PART HITS ASTEROID 
        if (contact.bodyA.node?.name == "ShipPart" && contact.bodyB.node?.name == "asteroid" ) {
            contact.bodyA.applyImpulse(contact.contactNormal, at: contact.contactPoint)
        }
        if (contact.bodyA.node?.name == "asteroid" && contact.bodyB.node?.name == "ShipPart" ) {
            contact.bodyB.applyImpulse(contact.contactNormal, at: contact.contactPoint)
        }
        
        if (state == .InGame) {
            // PLAYER HITS HEALTH PICKUP
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "HealthPickup" ) {
                player.pickupHealth()
                userInterface.flashHealthBar()
            }
            if (contact.bodyA.node?.name == "HealthPickup" && contact.bodyB.node?.name == "player" ) {
                player.pickupHealth()
                userInterface.flashHealthBar()
            }
            // PLAYER HITS AMMO PICKUP
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "AmmoPickup" ) {
                player.pickupAmmo()
                userInterface.flashAmmoBar()
            }
            if (contact.bodyA.node?.name == "AmmoPickup" && contact.bodyB.node?.name == "player" ) {
                player.pickupAmmo()
                userInterface.flashAmmoBar()
            }
            // PLAYER HITS POINTS PICKUP
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "PointsPickup_25" ) {
                player.give(points: 25)
                userInterface.flashScore()
            }
            if (contact.bodyA.node?.name == "PointsPickup_25" && contact.bodyB.node?.name == "player" ) {
                player.give(points: 25)
                userInterface.flashScore()
            }
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "PointsPickup_50" ) {
                player.give(points: 25)
                userInterface.flashScore()
            }
            if (contact.bodyA.node?.name == "PointsPickup_50" && contact.bodyB.node?.name == "player" ) {
                player.give(points: 50)
                userInterface.flashScore()
            }
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "PointsPickup_100" ) {
                player.give(points: 100)
                userInterface.flashScore()
            }
            if (contact.bodyA.node?.name == "PointsPickup_100" && contact.bodyB.node?.name == "player" ) {
                player.give(points: 100)
                userInterface.flashScore()
            }
        }
    }
}
