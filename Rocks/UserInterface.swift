/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  UserInterface.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class UserInterface: SKNode {
        private var mainMenu: MainMenu!
        private var gameHUD: GameHUD!
        private var pauseMenu: PauseMenu!
        private var gameOver: GameOverScreen!
        
        private var highScore: Int!
        
        func flashScore     () { gameHUD.flashScore() }
        func flashAmmoBar   () { gameHUD.flashAmmoBar() }
        func flashHealthBar () { gameHUD.flashHealthBar() }
        
        init (width: Int, height: Int, player: Player, highScore: Int) {
            super.init()
            
            mainMenu  = MainMenu(w: width, h: height, p: player)
            gameHUD   = GameHUD(w: width, h: height, p: player)
            pauseMenu = PauseMenu(w: width, h: height, p: player)
            gameOver  = GameOverScreen(w: width, h: height, p: player)
            
            addChild(mainMenu)
            addChild(gameHUD)
            addChild(pauseMenu)
            addChild(gameOver)
            
            mainMenu.isHidden  = true
            gameHUD.isHidden   = true
            pauseMenu.isHidden = true
            gameOver.isHidden  = true
            
            
            self.zPosition = 2
            self.highScore = highScore
        }
        
        /* * * * * * * * * * * * * * * * * * * * *
         *  UPDATE UI
         * * * * * * * * * * * * * * * * * * * * */
        func update (state: GameState) {
            
            // switch on game state
            switch (state) {
                case .MainMenu:
                    gameOver.isHidden = true
                    mainMenu.isHidden = false
                    mainMenu.update()
                    break
                case .Running:
                    mainMenu.isHidden = true
                    pauseMenu.isHidden = true
                    gameHUD.isHidden = false
                    gameHUD.update()
                    break
                case .Paused:
                    gameHUD.isHidden = true
                    pauseMenu.isHidden = false
                    pauseMenu.update()
                    break
                case .GameOver:
                    gameHUD.isHidden = true
                    gameOver.isHidden = false
                    gameOver.update()
                    break
            }
        }
        
        // ??
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
