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
    
    var player: Player = Player()
    var hud: HUD = HUD()
    
    let save = Save()
    
    let pauseBlur = SKEffectNode()
    
    //Accelerometer
    let motionManager = CMMotionManager()
    
    var playing: Bool!

    // On-Start
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector (dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        //Accelerometer start updating
        motionManager.startAccelerometerUpdates()
        
        addChild(player.spawn(x: Int(self.size.width / 2), y: 160))
        addChild(hud.initialise(width:Int(self.size.width) ,height: Int(self.size.height)))
        
        // pause blur
        let blur = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius": 10.0])
        pauseBlur.filter = blur
        addChild(pauseBlur)
        

        playing = true
    }
    
    // On-Update
    override func update(_ currentTime: TimeInterval) {
        
        // SORT CHILDREN ARRAY SO ALL LABELS ARE AT WHICHEVER END GETS RENDERED LAST
        /*
        func renderQueueSort (nodes: (SKNode,SKNode)) -> Bool {
            return (nodes.0.name?.contains("Label"))!
        }
        
        children.sort(by: renderQueueSort) // according to the documentation this call should work but it won't compile
        */
        
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
        
        // always update movement
        // shouldn't we not process movement when paused? - Ryan
        processUserMotion(forUpdate: currentTime)
    }
    
    // On-Update delegate I
    func updateWithLast (lastUpdate: CFTimeInterval) {
        lastYieldTimeInterval += lastUpdate
        if (lastYieldTimeInterval > 0.6) {
            lastYieldTimeInterval = 0
            
            // 10 points for every asteroid on screen (this should maybe depend on siae of asteroid)
            player.give(points: 10)
            let asteroid = Asteroid()
            
            addChild ( asteroid.spawn(
                x: Int(arc4random_uniform(UInt32(self.size.width))),
                y: Int(self.size.height + 50))
            )
            
            // maybe spawn a powerup
            let ting = Int(arc4random_uniform(100))
            if (ting < 12) {
                let powerup = Powerup()
                
                addChild ( powerup.spawn(
                    x: Int(arc4random_uniform(UInt32(self.size.width))),
                    y: Int(self.size.height + 50))
                )
            }
        }
        

    }
    
    func resetGame () {
        hud.reset()
        player.moveTo(x: Int(self.size.width / 2), y: 160)
        
        // remove asteroids
        for child in children {
            if(child.name == "asteroid"){
                child.removeFromParent()
            }
        }
        
        playing  = true
        isPaused = false
        
    }
}
