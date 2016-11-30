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
        public let x: Int!
        public let y: Int!
        public let z: Int!
        
        init (x: Int, y: Int, z: Int) {
            self.x = x
            self.y = y
            self.z = z
        }
        
        //For the leaderboard ship viewing
        init (context: UInt64) {
            let stringVersion = String(context)
            //print(String(context))
            var splitter = stringVersion.components(separatedBy: "999")
            //print("This is the splitter: \(splitter)")
            //let xString  = "01"//"\(stringVersion.characters.popFirst()!)\(stringVersion.characters.popFirst()!)"
            //let yString  = "01"//"\(stringVersion.characters.popFirst()!)\(stringVersion.characters.popFirst()!)"
            //let zString  = "01"//"\(stringVersion.characters.popFirst()!)\(stringVersion.characters.popFirst()!)"
            self.x       = Int(splitter.removeFirst())!
            self.y       = Int(splitter.removeFirst())!
            self.z       = Int(splitter.removeFirst())!
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
            print("Get As One: " + string)
            return Int(string)!
        }
        
        func parseForLeaderboard() -> Int {
            let string = "\(self.x!)999\(self.y!)999\(self.z!)"
            //print("Parsed: " + string)
            return Int(string)!
        }
    }
}
