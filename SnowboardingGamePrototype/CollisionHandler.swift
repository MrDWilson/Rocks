//
//  CollisionHandler.swift
//  SnowboardingGamePrototype
//
//  Created by user on 09/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit
import AudioToolbox

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
        if (contact.bodyA.node?.name == "PlayerOne" && contact.bodyB.node?.name == "asteroid" ) {
            hud.gameEnded()
            hud.update(state: isPaused, score: player.getScore()) // HUD needs to be updated before a pause
            player.clearLasers()
            playing  = false
            isPaused = true
            
            // save high scores
            if(player.getScore() > save.getHighScore()) {
                save.setHighScore(x: player.getScore())
                save.saveToiCloud()
            }
            
            // bzzz
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        if (contact.bodyA.node?.name == "asteroid" && contact.bodyB.node?.name == "PlayerOne" ) {
            hud.gameEnded()
            hud.update(state: isPaused, score: player.getScore()) // HUD needs to be updated before a pause
            player.clearLasers()
            playing  = false
            isPaused = true
            
            // save high scores
            if(player.getScore() > save.getHighScore()) {
                save.setHighScore(x: player.getScore())
                save.saveToiCloud()
            }
            
            // bzzz
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
        // PLAYER HITS POWERUP
        if (contact.bodyA.node?.name == "PlayerOne" && contact.bodyB.node?.name == "powerup" ) {
            contact.bodyB.node?.run(SKAction.removeFromParent())
            player.gotPowerUp()
        }
        
        if (contact.bodyA.node?.name == "powerup" && contact.bodyB.node?.name == "PlayerOne" ) {
            contact.bodyA.node?.run(SKAction.removeFromParent())
            player.gotPowerUp()
        }
    }
}
