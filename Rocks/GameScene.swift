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
    var asteroids       = [Asteroid]()
    var powerups        = [Powerup]()
    var player          = Player()
    var emitter: FragmentEmitter!
    
    // difficulty
    let initialAsteroidCount = 5
    let initialPowerupCount  = 5
    var currentLevel         = 1
    
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
    
    // music 
    var themeMusic = SKAudioNode(fileNamed: "background.mp3")
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ENTRY POINT
     * * * * * * * * * * * * * * * * * * * * */
    override func didMove(to view: SKView) {
        
        Save.iCloudSetUp() //Load previous save values
        sound = Save.getSound()
        vibrate = Save.getVibration()
        if(Save.getFirstTime()) { Save.resetHighScore(); Save.setFirstTime(); print("Reset") }
        
        player.buildShip()
        
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
        for _ in 0...initialAsteroidCount { asteroids.append(Asteroid()) }
        for _ in 0...initialPowerupCount  { powerups.append(Powerup()) }
        for _ in 0...420 {backdrop.append(Stars())}
        
        // line em up
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
        
        // show clear scene
        addChild(clearScene)
        
        // add music
        if (sound) {
            addChild(themeMusic)   
        }
        
        emitter = FragmentEmitter(w: self.size.width)
        emitter.add(to: self)
        
        themeMusic.autoplayLooped = true;
        
        /*
        if (!sound) {
            themeMusic.run(SKAction.changeVolume(by: -10, duration: 0))
        }
        */
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
                player.scaleTo(x: 2, y: 2)
                player.setRestingY(y: Int(self.size.height * CGFloat(0.65)))
                
                // ONCE PLAYER IS AT REST, HOLD THEM TO STOP BEING SHUNTED TO THE BOTTOM OF THE MENU
                
                if (player.getPosition().x > (self.size.width / 2) + 5) {
                    player.moveLeft()
                }
                
                if (player.getPosition().x < (self.size.width / 2) - 5) {
                    player.moveRight()
                }
                updateMainMenu(currentTime: currentTime)
                
                // spray
                emitter.setPosition(x: self.size.width / 2, y: self.size.height)
                emitter.update()
                
                break
            case .Customise:
                
                //player.scaleTo(x: 3.5, y: 3.5)
                player.setRestingY(y: Int(self.size.height * CGFloat(0.75)))
                player.setX (x: (self.size.width * 0.5))
                player.update(currentTime: currentTime)
                
                emitter.update()
            
                break
            case .Leaderboard:
                player.hide()
                player.scaleTo(x: 1.6, y: 1.6)
                player.setRestingY(y: Int(self.size.height * CGFloat(0.64)))
                player.update(currentTime: currentTime)
                
                // Code to make current player fly to their position on the leaderboard
                //player.scaleTo(x: 1.5, y: 1.5)
                //player.setRestingY(y: Int(self.size.height * CGFloat(0.90)))
                //if (player.getPosition().x > self.size.width * CGFloat(0.30)) {
                //    player.moveLeft()
                //}
                //player.update()
                
                break
            case .Options:
                
                player.setRestingY(y: Int(self.size.height * CGFloat(0.7)))
                player.update(currentTime: currentTime)
                
                emitter.update()
                
                break
            case .About:
            
                player.setRestingY(y: Int(self.size.height * CGFloat(0.7)))
                player.update(currentTime: currentTime)
                
                emitter.update()
            
                break
            case .InGame:
                
                player.scaleTo(x: 1.0, y: 1.0)
                updateRunning(currentTime: currentTime)
                
                emitter.update()
                
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
        
        // hold the player in place on the Y axis
        player.setRestingY(y: Int(self.size.height * CGFloat(0.32)))

        // get accelerometer input
        processUserMotion(forUpdate: currentTime)
        
        // update game actors
        asteroids.forEach { $0.update() }
        powerups.forEach { $0.update() }
        player.update(currentTime: currentTime)
        
        // "infinitly" increse difficulty
        if (player.getScore() > (currentLevel*2000)) {
            increaseDifficulty()
            currentLevel += 1
        }
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
    
        resetDifficulty()
        
        isPaused = false
        
        //  reset all asteroids and powerups
        asteroids.forEach { $0.quietDestroy() }
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
