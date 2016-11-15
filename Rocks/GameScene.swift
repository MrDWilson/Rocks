/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  GameScene.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit
import GameplayKit
import AudioToolbox
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    let clearScene = SKNode()
    let blurScene = SKEffectNode()
    
    var state = GameState.MainMenu

    /* * * * * * * * * * * * * * * * * * * * *
     *  GamePlay Aspects
     * * * * * * * * * * * * * * * * * * * * */
    var userInterface:  UserInterface!
    var motionManager   = CMMotionManager()
    var difficulty      = Difficulty.Easy
    var asteroids       = [Asteroid]()
    var powerups        = [Powerup]()
    var player          = Player()
    
    // Graphics Stuff
    var worldTextureCache   = TextureCache()
    
    // saver
    var playing = true
    var saver = Save()
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ENTRY POINT
     * * * * * * * * * * * * * * * * * * * * */
    override func didMove(to view: SKView) {
        userInterface = UserInterface(width: Int(self.size.width), height: Int(self.size.height), player: player, highScore: saver.getHighScore())
    
        view.shouldCullNonVisibleNodes = true
        
        // set up physics stuff
        physicsWorld.gravity = CGVector (dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        //Stop screen dimming
        UIApplication.shared.isIdleTimerDisabled = true
        
        //Accelerometer start updating
        motionManager.startAccelerometerUpdates()
        
        // make some asteroids and powerups
        for _ in 0...difficulty.rawValue { asteroids.append(Asteroid()) }
        for _ in 0...difficulty.rawValue { powerups.append(Powerup()) }
        
        asteroids.forEach {
            $0.setXConfine(con: Int(self.size.width))
            $0.setYConfine(con: Int(self.size.height))
        }
        powerups.forEach  {
            $0.setXConfine(con: Int(self.size.width))
            $0.setYConfine(con: Int(self.size.height))
        }
        
        // spawn player and HUD
        clearScene.addChild(player.spawn(x: Int(self.size.width / 2), y: Int(self.size.height / 4)))
        addChild(userInterface)
        
        // spawn asteroids and powerups
        asteroids.forEach { clearScene.addChild($0.spawn(textureCache: worldTextureCache)) }
        powerups.forEach  { clearScene.addChild($0.spawn(textureCache: worldTextureCache)) }
        
        // set up blur filter
        blurScene.filter = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius": 5.5])
        
        // show clear scene
        addChild(clearScene)
    }
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ON-UPDATE
     * * * * * * * * * * * * * * * * * * * * */
    override func update(_ currentTime: TimeInterval) {
        userInterface.update(state: state)
        
        switch (state) {
            case .MainMenu:
            
                updateMainMenu()
                
                break
            case .Customise:
                
                player.update()
            
                break
            case .Leaderboard:
                
                
            
                break
            case .Options:
                
                
                
                break
            case .About:
            
                break
            case .InGame:
                
                updateRunning(currentTime: currentTime)
                
                break
            case .Paused:
                
                updatePaused()
                
                break
            case .GameOver:
                
                updateGameOver(currentTime: currentTime)
                
                break
        }
    }
    
    func updateMainMenu () {
        player.update()
    }
    
    func updateRunning (currentTime: TimeInterval) {
        // check/set difficulty
        if (player.getScore() > 5000) { difficulty = .Medium }
        if (player.getScore() > 15000) { difficulty = .Hard }
        
        // get input
        processUserMotion(forUpdate: currentTime)
        
        // update game actors
        asteroids.forEach { $0.update() }
        powerups.forEach { $0.update() }
        player.update()
        
        // ensure correct astroid count
        if (difficulty == .Medium) {
            if (asteroids.count == Difficulty.Easy.rawValue) {
                while (asteroids.count < Difficulty.Medium.rawValue) {
                    asteroids.append(Asteroid())
                    clearScene.addChild((asteroids.last?.spawn(textureCache: worldTextureCache))!)
                }
            }
        }
        
        if (difficulty == .Hard) {
            if (asteroids.count == Difficulty.Medium.rawValue) {
                while (asteroids.count < Difficulty.Hard.rawValue) {
                    asteroids.append(Asteroid())
                    clearScene.addChild((asteroids.last?.spawn(textureCache: worldTextureCache))!)
                }
            }
        }
    }
    
    func updatePaused () {
        
    }
    
    func updateGameOver (currentTime: TimeInterval) {
        
        // putting these in the if statement makes tem
        // stop. Investigate
        asteroids.forEach { $0.update() }
        powerups.forEach { $0.update() }
        
        if (currentTime.remainder(dividingBy: 24) == 0) {
            // update game actors
            player.update()
        }
    }
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  RESTART
     * * * * * * * * * * * * * * * * * * * * */
    func resetGame () {
        // reset player and HUD
        player.resetAt(x: Int(self.size.width / 2), y: Int(self.size.height / 4))

        difficulty = .Easy
        while (asteroids.count > difficulty.rawValue) {
            asteroids.last?.destroyed()
            asteroids.last?.culled()
            asteroids.removeLast()
        }
    
        isPaused = false
        
        //  reset all asteroids and powerups
        asteroids.forEach { $0.destroyed() }
        powerups.forEach  { $0.collected() }
    }
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  BLUR / UNBLUR FUNCTIONS
     * * * * * * * * * * * * * * * * * * * * */
    func blur () {
        clearScene.removeFromParent()
        blurScene.addChild(clearScene)
        blurScene.removeFromParent()
        addChild(blurScene)
    }
    
    func unblur () {
        clearScene.removeFromParent()
        addChild(clearScene)
        blurScene.removeFromParent()
    }
}
