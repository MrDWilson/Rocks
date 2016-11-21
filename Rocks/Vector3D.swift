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
        public var x: CGFloat!
        public var y: CGFloat!
        public var z: CGFloat!
        
        init (x: CGFloat, y: CGFloat, z: CGFloat) {
            self.x = x
            self.y = y
            self.z = z
        }
        
        //For the leaderboard ship viewing
        init (context: Int) {
            var stringVersion = String(context)
            let xString  = "\(stringVersion.characters.popFirst()!)\(stringVersion.characters.popFirst()!)"
            let yString  = "\(stringVersion.characters.popFirst()!)\(stringVersion.characters.popFirst()!)"
            let zString  = "\(stringVersion.characters.popFirst()!)\(stringVersion.characters.popFirst()!)"
            self.x       = CGFloat(Int(xString)!)
            self.y       = CGFloat(Int(yString)!)
            self.z       = CGFloat(Int(zString)!)
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
