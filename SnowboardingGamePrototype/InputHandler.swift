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
    // TO-DO: if player swipes down on either side, rotate player
    // TO-DO: add a ship weapon
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
//            let center = CGFloat(self.size.width / 2)
            let node   = self.atPoint(location)
            
            if (node.name == "PauseButton") || (node.name == "PauseLabel") {
                
                if (!isPaused) {
                    // blur scene
                    children.forEach {
                        // DONT BLUR LASERS - LOOKS COOL
                        if ($0.name == String("asteroid")) ||
                           ($0.name == String("PlayerOne")) ||
                           ($0.name == String("powerup")){
                            $0.removeFromParent()
                            pauseBlur.addChild($0)
                        }
                    }
                
                    isPaused = true
                }
                
                else {
                    // unblur scene
                    pauseBlur.children.forEach { $0.removeFromParent(); addChild($0) }
                    isPaused = false
                }
                
               // isPaused = !isPaused
                hud.update(state: isPaused, score: player.getScore())
            }
            
            else {
                if (!isPaused) {
                    addChild(player.fireLaser())
                }
            }
            
            if (!playing) {
                resetGame()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _: AnyObject in touches {

        }
    }
    
    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
        if let ship = childNode(withName: player.getName()) as? SKSpriteNode {
            if let data = motionManager.accelerometerData {
                if fabs(data.acceleration.x) > 0.06 {
                    ship.physicsBody!.applyForce(CGVector(dx: 90 * CGFloat(data.acceleration.x), dy: 0))
                }
            }
        }
    }
}
