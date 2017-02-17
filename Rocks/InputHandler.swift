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
    func touchDown(atPoint pos : CGPoint) {
        print(pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        print(pos)
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print(pos)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch began")
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
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
                    player.cullLasers()
                } else if (node.name == "optionsButton") {
                    state = .Options
                } else if (node.name == "aboutButton") {
                    state = .About
                } else if (touch.location(in: self).y > self.size.height / 2) {
                    backdrop.forEach { $0.setSpeed(s: -4) }
                    state = .InGame
                }
                break
            case .Customise:
                if (node.name == "NEXT_BODY") {
                    
                    // SWAP BODY
                    print ("next body")
                    
                } else if (node.name == "PREV_BODY") {
                    
                    // SWAP BODY
                    print ("prev body")
                    
                } else if (node.name == "NEXT_LWING") {
                    
                    // SWAP LEFT WING
                    print ("next left wing")
                    
                } else if (node.name == "PREV_LWING") {
                    
                    // SWAP LEFT WING
                    print ("prev left wing")
                
                } else if (node.name == "NEXT_RWING") {
                
                    // SWAP RIGHT WING
                    print ("next right wing")
                    
                } else if (node.name == "PREV_RWING") {
                    
                    // SWAP RIGHT WING
                    print ("prev right wing")
                    
                } else if (node.name == "NEXT_CORE") {
                    
                    // SWAP CORE
                    print ("next core")
                    
                } else if (node.name == "PREV_CORE") {
                    
                    // SWAP CORE
                    print ("prev core")
                    
                } else {
                    state = .MainMenu
                    userInterface.back()
                }
                break
            case .Leaderboard:
                if (node.name == "ship") {
                    state = .MainMenu
                    userInterface.back()
                } else if (touch.location(in: self).y > self.size.height / 2) {
                    userInterface.scrollLeaderboardUp()
                } else {
                    userInterface.scrollLeaderboardDown()
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
                break
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches ended")
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches moved")
        
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("")
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
