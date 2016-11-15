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
                    state = .Running
                    break
                case .Running:
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
                    state = .Running
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
