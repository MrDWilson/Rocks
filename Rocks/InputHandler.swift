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
            let location = touch.location(in: self)
            let node     = self.atPoint(location)
            
            if (node.name == "PauseButton") || (node.name == "PauseLabel") {
                if (playing) {
                    if (!isPaused) {
                        //blur()
                        isPaused = true
                    }
                        
                    else {
                        //unblur()
                        isPaused = false
                    }
                    
                    hud.update(state: isPaused, score: player.getScore())
                }
            }
            
            else {
                if !isPaused && playing { player.fireLaser() }
                
                if isPaused {
                    isPaused = false
                    //unblur()
                }
                
                if (!playing) { resetGame() }
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
