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
    var worldTextureCache = TextureCache()
    var backdrop          = [Stars]()
    
    // saver
    var playing = true
    
    // preferences
    var sound = true
    var vibrate = true
    
    // input
    var touches = NSMutableArray()
    
    //Leaderboard
    let leaderboard = LeaderboardBackEnd()
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ENTRY POINT
     * * * * * * * * * * * * * * * * * * * * */
    override func didMove(to view: SKView) {
        Save.iCloudSetUp() //Load previous save values
        sound = Save.getSound()
        vibrate = Save.getVibration()
        
        userInterface = UserInterface (
            width: Int(self.size.width),
            height: Int(self.size.height),
            player: player,
            highScore: Save.getHighScore(),
            sound: Save.getSound(),
            vibrate: Save.getVibration()
        )
    
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
        for _ in 0...400 {backdrop.append(Stars())}
        
        asteroids.forEach {
            $0.setXConfine(con: Int(self.size.width))
            $0.setYConfine(con: Int(self.size.height))
        }
        powerups.forEach  {
            $0.setXConfine(con: Int(self.size.width))
            $0.setYConfine(con: Int(self.size.height))
        }
        
        // spawn player and HUD
        clearScene.addChild(player.spawn(x: Int(CGFloat(self.size.width / 2)), y: Int(self.size.height * CGFloat(0.58))))
        addChild(userInterface)
        
        // spawn asteroids, powerups and stars
        asteroids.forEach { clearScene.addChild($0.spawn(textureCache: worldTextureCache)) }
        powerups.forEach  { clearScene.addChild($0.spawn(textureCache: worldTextureCache, player: player)) }
        backdrop.forEach  { clearScene.addChild($0.spawn())}
        
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
        backdrop.forEach { $0.update() }
        
        switch (state) {
            case .MainMenu:
                player.show()
                player.scaleTo(x: 1.6, y: 1.6)
                player.setRestingY(y: Int(self.size.height * CGFloat(0.64)))
                if (player.getPosition().x > (self.size.width / 2) + 5) {
                    player.moveLeft()
                }
                
                if (player.getPosition().x < (self.size.width / 2) - 5) {
                    player.moveRight()
                }
                updateMainMenu(currentTime: currentTime)
                
                break
            case .Customise:
                
                player.scaleTo(x: 3.5, y: 3.5)
                player.setRestingY(y: Int(self.size.height * CGFloat(0.50)))
                player.update(currentTime: currentTime)
            
                break
            case .Leaderboard:
                player.hide()
                //player.scaleTo(x: 1.5, y: 1.5)
                //player.setRestingY(y: Int(self.size.height * CGFloat(0.90)))
                //if (player.getPosition().x > self.size.width * CGFloat(0.30)) {
                //    player.moveLeft()
                //}
                //player.update()
                
                break
            case .Options:
                
                
                
                break
            case .About:
            
                player.setRestingY(y: Int(self.size.height * CGFloat(0.7)))
                player.update(currentTime: currentTime)
            
                break
            case .InGame:
                
                player.scaleTo(x: 1.0, y: 1.0)
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
    
    func updateMainMenu (currentTime: TimeInterval) {
        player.update(currentTime: currentTime)
    }
    
    func updateRunning (currentTime: TimeInterval) {
        //
        player.setRestingY(y: Int(self.size.height * CGFloat(0.32)))
        
        if (player.getScore() % 5000 == 0) && player.getScore() > 0 {
            backdrop.forEach { $0.speedUp() }
            asteroids.append(Asteroid())
            clearScene.addChild((asteroids.last?.spawn(textureCache: worldTextureCache))!)
            
            if (player.getScore() > 40000) {
                asteroids.append(Asteroid())
                clearScene.addChild((asteroids.last?.spawn(textureCache: worldTextureCache))!)
            }
        }
    
        /*
        // check/set difficulty
        if (player.getScore() > 5000) { difficulty = .Medium; backdrop.forEach { $0.speedUp() } }
        if (player.getScore() > 15000) { difficulty = .Hard }
        */
        
        // get input
        processUserMotion(forUpdate: currentTime)
        
        // update game actors
        asteroids.forEach { $0.update() }
        powerups.forEach { $0.update() }
        player.update(currentTime: currentTime)
        
        /*
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
        */
    }
    
    func updatePaused () {
        
    }
    
    func updateGameOver (currentTime: TimeInterval) {
        
        asteroids.forEach { $0.update() }
        powerups.forEach { $0.update() }
        player.update(currentTime: currentTime)
        
        /*
        // broken slo-mo
        if (currentTime.remainder(dividingBy: 64) < 5) {
            // update game actors
            // putting these in the if statement makes tem
            // stop. Investigate
            asteroids.forEach { $0.update() }
            powerups.forEach { $0.update() }
            player.update()
        }
        */
    }
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  RESTART
     * * * * * * * * * * * * * * * * * * * * */
    func resetGame () {
        // reset player and HUD
        player.resetAt(x: Int(self.size.width * CGFloat(0.5)), y: Int(self.size.height * CGFloat(0.58)))

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
