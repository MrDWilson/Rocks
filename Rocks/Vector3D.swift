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
    }
}
