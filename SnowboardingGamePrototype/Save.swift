//
//  Save.swift
//  SnowboardingGamePrototype
//
//  Created by Danny Wilson on 08/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//
import Foundation

extension GameScene {
    
    class Save {
        
        //Cloud save
        var iCloudKeyStore: NSUbiquitousKeyValueStore? = NSUbiquitousKeyValueStore()
        let iCloudTextKey = "highScore"
        var highScore = 0
        
        func saveToiCloud() {
            iCloudKeyStore?.set(highScore, forKey: iCloudTextKey)
            iCloudKeyStore?.synchronize()
        }
        
        func iCloudSetUp() {
            if let savedString = iCloudKeyStore?.longLong(forKey: iCloudTextKey) {
                highScore = Int(savedString)
            }
        }
        
        func resetHighScore() {
            highScore = 0
            saveToiCloud()
        }
        
        func getHighScore() -> Int {
            return highScore
        }
        
        func setHighScore(x : Int) {
            highScore = x
        }
        
    }
}
