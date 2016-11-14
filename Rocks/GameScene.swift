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
    //let blurScene = SKEffectNode()

    /* * * * * * * * * * * * * * * * * * * * *
     *  GamePlay Aspects
     * * * * * * * * * * * * * * * * * * * * */
    var motionManager   = CMMotionManager()
    var difficulty      = Difficulty.Easy
    var asteroids       = [Asteroid]()
    var powerups        = [Powerup]()
    var player          = Player()
    var hud             = HUD()
    
    // Graphics Stuff
    var worldTextureCache   = TextureCache()
    
    // saver
    var playing = true
    var saver = Save()
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ENTRY POINT
     * * * * * * * * * * * * * * * * * * * * */
    override func didMove(to view: SKView) {
    
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
        clearScene.addChild(player.spawn(x: Int(self.size.width / 2), y: 228))
        clearScene.addChild(hud.initialise(width:Int(self.size.width), height: Int(self.size.height), player: player))
        
        // spawn asteroids and powerups
        asteroids.forEach { clearScene.addChild($0.spawn(textureCache: worldTextureCache)) }
        powerups.forEach  { clearScene.addChild($0.spawn(textureCache: worldTextureCache)) }
        
        // set up blur filter
        //blurScene.filter = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius": 5.5])
        
        // show clear scene
        addChild(clearScene)
    }
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  ON-UPDATE
     * * * * * * * * * * * * * * * * * * * * */
    override func update(_ currentTime: TimeInterval) {
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
        
        // always update HUD
        hud.update(state: isPaused, score: player.getScore())

    }
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  RESTART
     * * * * * * * * * * * * * * * * * * * * */
    func resetGame () {
        // reset player and HUD
        player.resetAt(x: Int(self.size.width / 2), y: 160)
        hud.reset()
        
        // remove scene blur
        //unblur()

        // reset difficulty
        difficulty = .Easy
        while (asteroids.count > difficulty.rawValue) {
            asteroids.last?.destroyed()
            asteroids.last?.culled()
            asteroids.removeLast()
        }
        
        playing  = true
        isPaused = false
        
        //  reset all asteroids and powerups
        asteroids.forEach { $0.destroyed() }
        powerups.forEach  { $0.collected() }
    }
    
    /* * * * * * * * * * * * * * * * * * * * *
     *  BLUR / UNBLUR FUNCTIONS
     * * * * * * * * * * * * * * * * * * * * */
    /*
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
    */
    /*
    func blurScene () {
        // blur scene
        children.forEach {
            // DONT BLUR LASERS - LOOKS COOL
            if ($0.name == String("asteroid"))          ||
               ($0.name == String("player"))            ||
               ($0.name == String("HealthPickup"))      ||
               ($0.name == String("AmmoPickup"))        ||
               ($0.name == String("PointsPickup_25"))   ||
               ($0.name == String("PointsPickup_50"))   ||
               ($0.name == String("PointsPickup_100"))  ||
               ($0.name == String("explosion"))         ||
               ($0.name == String("ShipPart")) {
                $0.removeFromParent()
                pauseBlur.addChild($0)
            }
        }
    }
    
    func unblurScene () {
        pauseBlur.children.forEach {
            $0.removeFromParent()
            addChild($0)
        }
    }
     */
}
