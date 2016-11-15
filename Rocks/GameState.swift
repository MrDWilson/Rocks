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
        case MainMenu = 0
        case Running  = 1
        case Paused   = 2
        case GameOver = 3
    }
}
