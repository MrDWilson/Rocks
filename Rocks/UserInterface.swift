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
        
        private var needsRefresh = true;
        
        private var inGame = false;
        
        func flashScore     () { gameHUD.flashScore() }
        func flashAmmoBar   () { gameHUD.flashAmmoBar() }
        func flashHealthBar () { gameHUD.flashHealthBar() }
        
        func showCustomiseMenu () {
            mainMenu.hide()
            mainMenu_customise.isHidden = false
        }
        
        func scrollLeaderboardUp () {
            leaderboard.scrollUp()
        }
        
        func scrollLeaderboardDown () {
            leaderboard.scrollDown()
        }
        
        func showLeaderboard () {
            mainMenu.hide()
            mainMenu_leaderboard.isHidden = false
            
            if (needsRefresh) {
                mainMenu_leaderboard.loadLeaderboard(w: screenWidth, h: screenHeight)
                needsRefresh = false
            }
            
        }
        
        func startGame () {
            gameHUD.start ()
            gameHUD.show  ()
        }
        
        func showOptions () {
            mainMenu.hide()
            mainMenu_options.show()
        }
        
        func showAbout () {
            mainMenu.hide()
            mainMenu_about.show()
        }
        
        func back () {
            mainMenu_customise.isHidden = true
            mainMenu_leaderboard.isHidden = true
            mainMenu_options.hide ()
            mainMenu_about.hide()
            needsRefresh = true;

            Save.setShip(ship: player.serializeShip())
        }
        
        func toggleSound () {
            mainMenu_options.toggleSound()
        }
        
        func toggleVibrate () {
            mainMenu_options.toggleVibrate()
        }
        
        init (width: Int, height: Int, player: Player, highScore: Int, sound: Bool, vibrate: Bool) {
            self.player = player
            self.screenWidth = width
            self.screenHeight = height
            
            super.init()
            
            mainMenu             = MainMenu(w: width, h: height, p: player)
            mainMenu_customise   = CustomiseScreen(w: width, h: height, p: player)
            mainMenu_leaderboard = LeaderboardFrontEnd(w: width, h: height, p: player)
            mainMenu_options     = OptionsScreen(w: width, h: height, p: player, sound: sound, vibrate: vibrate)
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

            mainMenu.hide()
            mainMenu_customise.isHidden = true
            mainMenu_leaderboard.isHidden = true
            mainMenu_options.hide ()
            mainMenu_about.hide()
            
            gameHUD.hide()
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
                    mainMenu.show()
                    mainMenu.update()
                    
                    //gameHUD.update()
                    mainMenu_options.update()
                    mainMenu_about.update()
                    break
                case .Customise:
                    
                    showCustomiseMenu()
                    mainMenu_customise.update()
                    
                    mainMenu.hide()
                    mainMenu.update()
                    break
                case .Leaderboard:
                    showLeaderboard()
                    
                    mainMenu.hide()
                    mainMenu.update()
                    break
                case .Options:
                    showOptions()
                    mainMenu_options.update()
                    
                    mainMenu.hide()
                    mainMenu.update()
                    break
                case .About:
                    showAbout()
                    mainMenu_about.update()
                    
                    mainMenu.hide()
                    mainMenu.update()
                    break
                case .InGame:
                    mainMenu.hide()
                    mainMenu.update()
                    pauseMenu.isHidden = true
                    
                    // animate player
                    if (Int(player.getPosition().y) < Int(CGFloat(screenHeight) * 0.34)) {
                        startGame()
                    }
                    
                    gameHUD.show()
                    gameHUD.update()
                    break
                case .Paused:
                    gameHUD.hide()
                    gameHUD.update()
                    pauseMenu.isHidden = false
                    pauseMenu.update()
                    break
                case .GameOver:
                    gameHUD.hide()
                    gameHUD.update()
                    gameHUD.clearTutorial()
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
