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
        
        private var leaderboard: LeaderboardFrontEnd!
        
        private var gameHUD: GameHUD!
        private var pauseMenu: PauseMenu!
        private var gameOver: GameOverScreen!
        
        private let player: Player!
        
        private let screenWidth: Int!
        private let screenHeight: Int!
        
        private var highScore: Int!
        
        func flashScore     () { gameHUD.flashScore() }
        func flashAmmoBar   () { gameHUD.flashAmmoBar() }
        func flashHealthBar () { gameHUD.flashHealthBar() }
        
        func showCustomiseMenu () {
            mainMenu.isHidden = true
            print("Customise")
        }
        
        func showLeaderboard () {
            mainMenu.isHidden = true
            print("Leaderboard")
        }
        
        func showOptions () {
            mainMenu.isHidden = true
            print("Options")
        }
        
        func showAbout () {
            mainMenu.isHidden = true
            print("About")
        }
        
        init (width: Int, height: Int, player: Player, highScore: Int) {
            self.player = player
            self.screenWidth = width
            self.screenHeight = height
            
            super.init()
            
            mainMenu  = MainMenu(w: width, h: height, p: player)
            
            leaderboard = LeaderboardFrontEnd(w: width, h: height, p: player)
            
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
                case .Customise:
                    // animate player
                    player.move(to: CGPoint(x: screenWidth / 2, y: Int(Double(screenHeight) * 0.82)))
                    
                    showCustomiseMenu()
                    break
                case .Leaderboard:
                    showLeaderboard()
                    break
                case .Options:
                    showOptions()
                    break
                case .About:
                    showAbout()
                    break
                case .InGame:
                    mainMenu.isHidden = true
                    pauseMenu.isHidden = true
                    
                    // animate player
                    if (Int(player.getPosition().y) < (Int(screenHeight / 4) + 24)) {
                        gameHUD.isHidden = false
                    }
                    
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
