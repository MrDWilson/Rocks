//
//  Vector3D.swift
//  Rocks
//
//  Created by user on 21/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit

extension GameScene {
    class Vector3D {
        public var x: Int!
        public var y: Int!
        public var z: Int!
        
        init (x: Int, y: Int, z: Int) {
            self.x = x
            self.y = y
            self.z = z
        }
        
        //For the leaderboard ship viewing
        init (context: UInt64) {
            var stringVersion = String(context)
            let xString  = "01"//"\(stringVersion.characters.popFirst()!)\(stringVersion.characters.popFirst()!)"
            let yString  = "01"//"\(stringVersion.characters.popFirst()!)\(stringVersion.characters.popFirst()!)"
            let zString  = "01"//"\(stringVersion.characters.popFirst()!)\(stringVersion.characters.popFirst()!)"
            self.x       = Int(xString)!
            self.y       = Int(yString)!
            self.z       = Int(zString)!
        }
        
        func add (other: Vector3D) {
            self.x = self.x + other.x
            self.y = self.y + other.y
            self.z = self.z + other.z
        }
        
        func subtract (other: Vector3D) {
            self.x = self.x - other.x
            self.y = self.y - other.y
            self.z = self.z - other.z
        }
        
        //Testing functionality
        func toString() -> String {
            return "x: \(self.x!), y: \(self.y!), z: \(self.z!)"
        }
        
        //Get functions
        
        func getX() -> Int {
            return Int(x)
        }
        
        func getY() -> Int {
            return Int(y)
        }
        
        func getZ() -> Int {
            return Int(z)
        }
        
        //Function to allow easy saving of ship to iCloud (potentially) and leaderboard
        func getAsOne() -> Int {
            let string = "\(self.x!)\(self.y!)\(self.z!)"
            return Int(string)!
        }
    }
}
