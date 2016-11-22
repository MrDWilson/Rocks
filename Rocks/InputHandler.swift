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
                if (node.name == "NEXT_SHIP") {
                    player.getShip().nextColour()
                } else if (node.name == "PREV_SHIP") {
                    player.getShip().prevColour()
                } else if (node.name == "NEXT_THRUSTER") {
                    player.getShip().nextThruster()
                } else if (node.name == "PREV_THRUSTER") {
                    player.getShip().prevThruster()
                } else if (node.name == "NEXT_LASER") {
                    player.nextLaserColour()
                } else if (node.name == "PREV_LASER") {
                    player.prevLaserColour()
                } else {
                    state = .MainMenu
                    userInterface.back()
                }
                break
            case .Leaderboard:
                if (node.name == "ship") {
                    state = .MainMenu
                    userInterface.back()
                } else {
                    state = .MainMenu
                    userInterface.back()
                }
                break
            case .Options:
                
                if (node.name == "sound") {
                    sound = !sound
                    userInterface.toggleSound()
                    Save.changeSound()
                } else if (node.name == "vibration") {
                    vibrate = !vibrate
                    userInterface.toggleVibrate()
                    Save.changeVibration()
                } else {
                    state = .MainMenu
                    userInterface.back()
                }
                break
            case .About:
                state = .MainMenu
                userInterface.back()
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
                    //player.startAutoFire()
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.stopAutoFire()
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
