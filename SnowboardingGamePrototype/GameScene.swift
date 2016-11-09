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

//  as if theres no fucking ++ or -- operator in swift 3...

//  as if an if statement doesn't compile without braces...

class GameScene: SKScene, SKPhysicsContactDelegate {
    var lastYieldTimeInterval = TimeInterval()
    var lastUpdateInterval    = TimeInterval()
    
    var player: Player = Player()
    var hud: HUD = HUD()
    
    let score = Counter()
    var timer = Timer()
    let save = Save()
    
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
        hud.update(state: isPaused, score: score.getCount())
        
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
            var i = 0
            while (i != 10) { score.increment(); i+=1;}
            let asteroid = Asteroid()
            
            addChild ( asteroid.spawn(
                x: Int(arc4random_uniform(UInt32(self.size.width))),
                y: Int(self.size.height + 50))
            )
        }
    }
    
    // On-Collision
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.node?.name == "PlayerOne") {
            hud.gameEnded()
            hud.update(state: isPaused, score: score.getCount()) // HUD needs to be updated before a pause
            player.clearLasers()
            playing  = false
            isPaused = true
            
            // save high scores
            if(score.getCount() > save.getHighScore()) {
                save.setHighScore(x: score.getCount())
                save.saveToiCloud()
            }
            
            if (contact.bodyA.node?.name == "laserbeam" && contact.bodyB.node?.name == "asteroid" ) {
                contact.bodyA.node?.run(SKAction.removeFromParent())
                contact.bodyB.node?.run(SKAction.removeFromParent())
            }
        
            if (contact.bodyA.node?.name == "asteroid" && contact.bodyB.node?.name == "laserbeam" ) {
               contact.bodyA.node?.run(SKAction.removeFromParent())
               contact.bodyB.node?.run(SKAction.removeFromParent())
            }
            
            // bzzz
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    func updateScore() {
        score.increment()
        print("Score:", score.getCount())
    }
    
    func resetGame () {
        score.reset()
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
