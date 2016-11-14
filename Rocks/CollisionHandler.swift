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
            hud.flashScore()
        }
        if (contact.bodyA.node?.name == "asteroid" && contact.bodyB.node?.name == "laserbeam" ) {
           // contact.bodyB.node?.removeFromParent()
            player.give(points: 25)
            hud.flashScore()
        }
        
        // PLAYER HITS ASTEROID
        if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "asteroid" ) ||
           (contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "asteroid" ) {
            ///*
            if (player.getHealth() == 0) {
                // bzzz
                if(!player.isExploding()) {
                    //AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
                
                player.spin()     // player node should be stationary,
                player.explode()
                player.clearLasers()
                
                hud.gameEnded()
                hud.update(state: isPaused, score: player.getScore()) // HUD needs to be updated before a pause
                playing = false
                
                //blur()
                
                // save high scores
                if(player.getScore() > saver.getHighScore()) {
                    saver.setHighScore(x: player.getScore())
                    saver.saveToiCloud()
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
        
        if (playing) {
            // PLAYER HITS HEALTH PICKUP
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "HealthPickup" ) {
                player.pickupHealth()
                hud.flashHealthBar()
            }
            if (contact.bodyA.node?.name == "HealthPickup" && contact.bodyB.node?.name == "player" ) {
                player.pickupHealth()
                hud.flashHealthBar()
            }
            // PLAYER HITS AMMO PICKUP
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "AmmoPickup" ) {
                player.pickupAmmo()
                hud.flashAmmoBar()
            }
            if (contact.bodyA.node?.name == "AmmoPickup" && contact.bodyB.node?.name == "player" ) {
                player.pickupAmmo()
                hud.flashAmmoBar()
            }
            // PLAYER HITS POINTS PICKUP
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "PointsPickup_25" ) {
                player.give(points: 25)
                hud.flashScore()
            }
            if (contact.bodyA.node?.name == "PointsPickup_25" && contact.bodyB.node?.name == "player" ) {
                player.give(points: 25)
                hud.flashScore()
            }
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "PointsPickup_50" ) {
                player.give(points: 25)
                hud.flashScore()
            }
            if (contact.bodyA.node?.name == "PointsPickup_50" && contact.bodyB.node?.name == "player" ) {
                player.give(points: 50)
                hud.flashScore()
            }
            if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "PointsPickup_100" ) {
                player.give(points: 100)
                hud.flashScore()
            }
            if (contact.bodyA.node?.name == "PointsPickup_100" && contact.bodyB.node?.name == "player" ) {
                player.give(points: 100)
                hud.flashScore()
            }
        }
    }
}
