/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  InputHandler.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ON - TOUCH
     * * * * * * * * * * * * * * * * * * * * */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            // get touched node
            let node = self.atPoint(touch.location(in: self))
            

            
            // switch on game state
            switch (state) {
                case .MainMenu:
                    player.setRestingY(y: Int((Double(self.size.width) * 0.25)))
                    if (node.name == "customiseButton") {
                        state = .Customise
                    } else if (node.name == "leaderboardButton") {
                        state = .Leaderboard
                    } else if (node.name == "optionsButton") {
                        state = .Options
                    } else if (node.name == "aboutButton") {
                        state = .About
                    } else if (touch.location(in: self).y > self.size.height / 2) {
                        backdrop.forEach { $0.speedUp() }
                        state = .InGame
                    }
                    break
                case .Customise:
                    if (node.name == "back") {
                        state = .MainMenu
                        userInterface.back()
                    }
                    break
                case .Leaderboard:
                    if (node.name == "back") {
                        state = .MainMenu
                        userInterface.back()
                    }
                    break
                case .Options:
                    if (node.name == "back") {
                        state = .MainMenu
                        userInterface.back()
                    }
                    
                    if (node.name == "sound") {
                        sound = !sound
                        userInterface.toggleSound()
                    }
                    
                    if (node.name == "vibration") {
                        vibrate = !vibrate
                        userInterface.toggleVibrate()
                    }
                    break
                case .About:
                    if (node.name == "back") {
                        state = .MainMenu
                        userInterface.back()
                    }
                    break
                case .InGame:
                    if (node.name == "PauseButton") {
                        state = .Paused
                        userInterface.update(state: state) // always update UI before pausing Subsystem
                        blur()
                        isPaused = true
                    }
                        
                    else {
                        player.fireLaser()
                    }
                    
                    break
                case .Paused:
                    state = .InGame
                    isPaused = false
                    unblur()
                    break
                case .GameOver:
                    state = .MainMenu
                    resetGame()
                    backdrop.forEach { $0.slowDown() }
                    break
            }
        }
    }
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ON - MOTION
     * * * * * * * * * * * * * * * * * * * * */
    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
        if let ship = clearScene.childNode(withName: player.getName()) as? SKSpriteNode {
            if let data = motionManager.accelerometerData {
                if fabs(data.acceleration.x) > 0.06 {
                    ship.physicsBody!.applyForce(CGVector(dx: 90 * CGFloat(data.acceleration.x), dy: 0))
                }
            }
        }
    }
}
