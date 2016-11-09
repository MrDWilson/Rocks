/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  CollisionMasks.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

// Collision Bit Mask
struct collision {
    static let player:UInt32 = 0x00
    static let asteroid:UInt32 = 0x01
    static let laserbeam:UInt32 = 0x02
}
