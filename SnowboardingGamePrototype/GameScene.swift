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

// git test
//  as if theres no fucking ++ or -- operator in swift 3...
//  as if an if statement doesn't compile without braces...
class GameScene: SKScene, SKPhysicsContactDelegate {
    var lastYieldTimeInterval = TimeInterval()
    var lastUpdateInterval    = TimeInterval()
    
    let pauseBlur: SKEffectNode = SKEffectNode()
    let player: Player          = Player()
    let hud: HUD                = HUD()
    var playing: Bool           = true
    
    let save = Save()
    
    //Accelerometer
    let motionManager = CMMotionManager()
    
    //Cache
    let textureCache = Cache()
    
    
    // On-Start
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector (dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        //Accelerometer start updating
        motionManager.startAccelerometerUpdates()
        
        // spawn a player, build a hud
        addChild(player.spawn(x: Int(self.size.width / 2), y: 160))
        addChild(hud.initialise(width:Int(self.size.width), height: Int(self.size.height), player: player))
        
        // set up blur filter
        pauseBlur.filter = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius": 10.0])
        addChild(pauseBlur)
    }
    
    // On-Update
    override func update(_ currentTime: TimeInterval) {
        
        // if not paused, spawn asteroids and move the player
        if (!isPaused) {
            var timeSinceLastUpdate = currentTime - lastUpdateInterval
            lastUpdateInterval = currentTime
            
            if (timeSinceLastUpdate > 2) {
                timeSinceLastUpdate = 1/60
                lastUpdateInterval = currentTime
            }
            
            updateWithLast(lastUpdate: timeSinceLastUpdate)
            
            player.update()
        }
        
        // always update HUD
        hud.update(state: isPaused, score: player.getScore())
        
        // apply blur if appropriate
        if (!playing) {
            blurScene()
        }
        
        // always update movement
        processUserMotion(forUpdate: currentTime)
    }
    
    // On-Update delegate I
    func updateWithLast (lastUpdate: CFTimeInterval) {
        lastYieldTimeInterval += lastUpdate
        if (lastYieldTimeInterval > 0.6) {
            lastYieldTimeInterval = 0
            
            // 10 points for every asteroid on screen (this should maybe depend on siae of asteroid)
            if (playing) {
                player.give(points: 10)
            }
            
            let asteroid = Asteroid()
            
            addChild ( asteroid.spawn(
                x: Int(arc4random_uniform(UInt32(self.size.width))),
                y: Int(self.size.height + 50),
                texture: textureCache.getCached(key: "asteroid"))
            )
            
            // maybe spawn a powerup
            let ting = Int(arc4random_uniform(100))
            if (ting < 33) {
                let powerup = Powerup()
                
                addChild ( powerup.spawn(
                    x: Int(arc4random_uniform(UInt32(self.size.width))),
                    y: Int(self.size.height + 50),
                    texture: textureCache)
                )
            }
        }
    }
    
    func resetGame () {
        unblurScene()
        hud.reset()
        player.moveTo(x: Int(self.size.width / 2), y: 160)
        
        // remove asteroids
        for child in children {
            if (child.name == "asteroid") ||
                (child.name == "HealthPickup") ||
                (child.name == "AmmoPickup") ||
                (child.name == "PointsPickup") {
                child.removeFromParent()
            }
        }
        
        playing  = true
        isPaused = false
        
    }
    
    func blurScene () {
        // blur scene
        children.forEach {
            // DONT BLUR LASERS - LOOKS COOL
            if ($0.name == String("asteroid")) ||
                ($0.name == String("PlayerOne")) ||
                ($0.name == String("HealthPickup")) ||
                ($0.name == String("AmmoPickup")) ||
                ($0.name == String("PointsPickup")) ||
                ($0.name == String("explosion")){
                $0.removeFromParent()
                pauseBlur.addChild($0)
            }
        }
    }
    
    func unblurScene () {
        // unblur scene
        pauseBlur.children.forEach { $0.removeFromParent(); addChild($0) }
    }
    
}
