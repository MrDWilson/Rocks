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
        
        private var mainMenu_customise: CustomiseScreen!
        private var mainMenu_leaderboard: LeaderboardFrontEnd!
        private var mainMenu_options: OptionsScreen!
        private var mainMenu_about: AboutScreen!
        
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
            mainMenu_customise.isHidden = false
        }
        
        func showLeaderboard () {
            mainMenu.isHidden = true
            mainMenu_leaderboard.isHidden = false
        }
        
        func showOptions () {
            mainMenu.isHidden = true
            mainMenu_options.isHidden = false
        }
        
        func showAbout () {
            mainMenu.isHidden = true
            mainMenu_about.isHidden = false
        }
        
        func back () {
            mainMenu_customise.isHidden = true
            mainMenu_leaderboard.isHidden = true
            mainMenu_options.isHidden = true
            mainMenu_about.isHidden = true
        }
        
        func toggleSound () {
            mainMenu_options.toggleSound()
        }
        
        func toggleVibrate () {
            mainMenu_options.toggleVibrate()
        }
        
        init (width: Int, height: Int, player: Player, highScore: Int) {
            self.player = player
            self.screenWidth = width
            self.screenHeight = height
            
            super.init()
            
            mainMenu             = MainMenu(w: width, h: height, p: player)
            mainMenu_customise   = CustomiseScreen(w: width, h: height, p: player)
            mainMenu_leaderboard = LeaderboardFrontEnd(w: width, h: height, p: player)
            mainMenu_options     = OptionsScreen(w: width, h: height, p: player)
            mainMenu_about       = AboutScreen(w: width, h: height, p:player)
            
            gameHUD   = GameHUD(w: width, h: height, p: player)
            pauseMenu = PauseMenu(w: width, h: height, p: player)
            gameOver  = GameOverScreen(w: width, h: height, p: player)
            
            addChild(mainMenu)
            addChild(gameHUD)
            addChild(pauseMenu)
            addChild(gameOver)
            addChild(mainMenu_customise)
            addChild(mainMenu_leaderboard)
            addChild(mainMenu_options)
            addChild(mainMenu_about)

            mainMenu.isHidden  = true
            mainMenu_customise.isHidden = true
            mainMenu_leaderboard.isHidden = true
            mainMenu_options.isHidden = true
            mainMenu_about.isHidden = true
            
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
                    if (Int(player.getPosition().y) < Int(CGFloat(screenHeight) * 0.34)) {
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
