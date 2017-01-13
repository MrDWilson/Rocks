/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  Difficulty.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
extension GameScene {
    
    func resetDifficulty () {
        currentLevel = 1
        
        // resset difficulty
        while (asteroids.count > initialAsteroidCount) {
            asteroids.last?.destroyed()
            asteroids.last?.culled()
            asteroids.removeLast()
        }
        
        while (powerups.count > initialPowerupCount) {
            powerups.last?.collected()
            powerups.last?.culled()
            powerups.removeLast()
        }
        
        backdrop.forEach  { $0.resetSpeed() }
        asteroids.forEach { $0.resetSpeed() }
        powerups.forEach  { $0.resetSpeed() }
    }
    
    func increaseDifficulty () {
        // add an asteroid
        asteroids.append(Asteroid())
        clearScene.addChild((asteroids.last?.spawn(textureCache: worldTextureCache))!)
        
        // add some powerups
        powerups.append(Powerup())
        clearScene.addChild((powerups.last?.spawn(textureCache: worldTextureCache, player: player))!)
        
        // speed up everything
        backdrop.forEach  { $0.setSpeed(s: $0.getSpeed() - 0.75) }
        asteroids.forEach { $0.setSpeed(s: $0.getSpeed() - 0.75) }
        powerups.forEach  { $0.setSpeed(s: $0.getSpeed() - 0.75) }
    }
}
