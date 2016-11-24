//
//  Save.swift
//  SnowboardingGamePrototype
//
//  Created by Danny Wilson on 08/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//
import Foundation
import SpriteKit

extension GameScene {
    
    class Save {
        
        //Cloud save
        private static var iCloudKeyStore: NSUbiquitousKeyValueStore? = NSUbiquitousKeyValueStore()
        //Keys for saving values
        private static let HS = "highScore"
        private static let VB = "vibration"
        private static let SND = "sound"
        private static let SHP = "shipID"
        private static let CLR = "colourID"
        private static let THRST = "thrusterID"
        private static let COIN = "coins"
        private static let FRST = "firstTime"
        //Values to be saved
        private static var highScore = 0
        private static var vibration = 1
        private static var sound = 1
        private static var shipID = 0
        private static var colourID = 0
        private static var thrusterID = 0
        private static var coins = 0
        private static var firstTime = 0
        
        //Generic save function
        static private func save(x : Int, y : String) {
            iCloudKeyStore?.set(x, forKey: y)
            iCloudKeyStore?.synchronize()
        }
        
        //Internal saving functions
        static private func saveHS() {
            save(x: highScore, y: HS)
        }
        
        static private func saveVibration() {
            save(x: vibration, y: VB)
        }
        
        static private func saveSound() {
            save(x: sound, y: SND)
        }
        
        static private func saveShipID() {
            save(x: shipID, y: SHP)
        }
        
        static private func saveColourID() {
            save(x: colourID, y: CLR)
        }
        
        static private func saveThrusterID() {
            save(x: thrusterID, y: THRST)
        }
        
        static private func saveShip() {
            save(x: shipID, y: SHP)
            save(x: colourID, y: CLR)
            save(x: thrusterID, y: THRST)
        }
        
        static private func saveCoins() {
            save(x: coins, y: COIN)
        }
        
        //Loading the values in when game is opened
        static func iCloudSetUp() {
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
        static func resetHighScore() {
            highScore = 0
            saveHS()
        }
        
        //Get methods for all values
        static func getHighScore() -> Int {
            return highScore
        }
        
        static func getVibration() -> Bool {
            if(vibration == 0) { return false } else { return true }
        }
        
        static func getSound() -> Bool {
            if(sound == 0) { return false } else { return true }
        }
        
        static func getShipID() -> Int {
            return shipID
        }
        
        static func getColourID() -> Int {
            return colourID
        }
        
        static func getThrusterID() -> Int {
            return thrusterID
        }
        
        static func getShip() -> Vector3D {
            return Vector3D(x: shipID, y: thrusterID, z: colourID)
        }
        
        static func getCoins() -> Int {
            return coins
        }
        
        static func getFirstTime() -> Bool {
            if firstTime == 0 {
                return false
            } else {
                return true
            }
        }
        
        //Set methods for all values
        static func setHighScore(x : Int) {
            highScore = x
            saveHS()
        }
        
        static func changeVibration() {
            if(vibration == 0) { vibration = 1 } else { vibration = 0 }
            saveVibration()
        }
        
        static func changeSound() {
            if(sound == 0) { sound = 1 } else { sound = 0 }
            saveSound()
        }
        
        static func setShipID(x: Int) {
            shipID = x
            saveShipID()
        }
        
        static func setColourID(x: Int) {
            colourID = x
            saveColourID()
        }
        
        static func setThrusterID(x: Int) {
            thrusterID = x
            saveThrusterID()
        }
        
        static func setShip(ship: Vector3D) {
            shipID = ship.getX()
            thrusterID = ship.getY()
            colourID = ship.getZ()
            saveShip()
            print("\(ship.getAsOne())")
        }
        
        static func addCoins(x: Int) {
            coins += x
            saveCoins()
        }
        
        static func removeCoins(x: Int) {
            coins -= x
            saveCoins()
        }
        
        static func setFirstTime() {
            if firstTime == 0 {
                firstTime = 1
            } else if firstTime == 1 {
                firstTime = 0
            }
        }
        
        
        
    }
}
