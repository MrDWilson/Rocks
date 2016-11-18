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
        private var iCloudKeyStore: NSUbiquitousKeyValueStore? = NSUbiquitousKeyValueStore()
        //Keys for saving values
        private let HS = "highScore"
        private let VB = "vibration"
        private let SND = "sound"
        private let SHP = "shipID"
        private let CLR = "colourID"
        private let THRST = "thrusterID"
        private let COIN = "coins"
        //Values to be saved
        private var highScore = 0
        private var vibration = 0
        private var sound = 0
        private var shipID = 0
        private var colourID = 0
        private var thrusterID = 0
        private var coins = 0
        
        //Generic save function
        private func save(x : Int, y : String) {
            iCloudKeyStore?.set(x, forKey: y)
            iCloudKeyStore?.synchronize()
        }
        
        //Internal saving functions
        private func saveHS() {
            save(x: highScore, y: HS)
        }
        
        private func saveVibration() {
            save(x: vibration, y: VB)
        }
        
        private func saveSound() {
            save(x: sound, y: SND)
        }
        
        private func saveShipID() {
            save(x: shipID, y: SHP)
        }
        
        private func saveColourID() {
            save(x: colourID, y: CLR)
        }
        
        private func saveThrusterID() {
            save(x: thrusterID, y: THRST)
        }
        
        private func saveCoins() {
            save(x: coins, y: COIN)
        }
        
        //Loading the values in when game is opened
        func iCloudSetUp() {
            if let highScoreSaved = iCloudKeyStore?.longLong(forKey: HS) {
                highScore = Int(highScoreSaved)
            }
            if let vibrationSaved = iCloudKeyStore?.longLong(forKey: VB) {
                vibration = Int(vibrationSaved)
            }
            if let soundSaved = iCloudKeyStore?.longLong(forKey: SND) {
                sound = Int(soundSaved)
            }
            if let shipSaved = iCloudKeyStore?.longLong(forKey: SHP) {
                shipID = Int(shipSaved)
            }
            if let colourSaved = iCloudKeyStore?.longLong(forKey: CLR) {
                colourID = Int(colourSaved)
            }
            if let thrusterSaved = iCloudKeyStore?.longLong(forKey: THRST) {
                thrusterID = Int(thrusterSaved)
            }
            if let coinsSaved = iCloudKeyStore?.longLong(forKey: COIN) {
                coins = Int(coinsSaved)
            }
        }
        
        //Reset High Score
        func resetHighScore() {
            highScore = 0
            saveHS()
        }
        
        //Get methods for all values
        func getHighScore() -> Int {
            return highScore
        }
        
        func getVibration() -> Bool {
            if(vibration == 0) { return false } else { return true }
        }
        
        func getSound() -> Bool {
            if(sound == 0) { return false } else { return true }
        }
        
        func getShipID() -> Int {
            return shipID
        }
        
        func getColourID() -> Int {
            return colourID
        }
        
        func getThrusterID() -> Int {
            return thrusterID
        }
        
        func getCoins() -> Int {
            return coins
        }
        
        //Set methods for all values
        func setHighScore(x : Int) {
            highScore = x
            saveHS()
        }
        
        func changeVibration() {
            if(vibration == 0) { vibration = 1 } else { vibration = 0 }
            saveVibration()
        }
        
        func changeSound() {
            if(sound == 0) { sound = 1 } else { sound = 0 }
            saveSound()
        }
        
        func setShipID(x: Int) {
            shipID = x
            saveShipID()
        }
        
        func setColourID(x: Int) {
            colourID = x
            saveColourID()
        }
        
        func setThrusterID(x: Int) {
            thrusterID = x
            saveThrusterID()
        }
        
        func addCoins(x: Int) {
            coins += x
            saveCoins()
        }
        
        func removeCoins(x: Int) {
            coins -= x
            saveCoins()
        }
        
        
        
    }
}
