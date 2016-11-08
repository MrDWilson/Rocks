//
//  InputHandler.swift
//  SnowboardingGamePrototype
//
//  Created by Ryan Needham on 08/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit

extension GameScene {
    // TO-DO: if player swipes down on either side, rotate player
    // TO-DO: add a ship weapon
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let center = CGFloat(self.size.width / 2)
            
            if (touch.location(in: self).x < center) {
                player.startMovingLeft()
            }
            
            if (touch.location(in: self).x > center) {
                player.startMovingRight()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _: AnyObject in touches {
            player.stopMovingLeft()
            player.stopMovingRight()
        }
    }
}
