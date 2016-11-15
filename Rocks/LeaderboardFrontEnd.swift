/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  LeaderboardFrontEnd.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class LeaderboardFrontEnd {
        private var backend: LeaderboardBackEnd!
        
        init (w: Int, h: Int, p: Player) {
            backend = LeaderboardBackEnd()
        }
        
        func update () {
            
        }
    }
}
