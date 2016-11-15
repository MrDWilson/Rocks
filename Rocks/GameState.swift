/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  Difficulty.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
extension GameScene {
    enum GameState : Int {
        case MainMenu    = 0
        case Customise   = 1
        case Leaderboard = 2
        case Options     = 3
        case About       = 4
        case InGame      = 5
        case Paused      = 6
        case GameOver    = 7
    }
}
