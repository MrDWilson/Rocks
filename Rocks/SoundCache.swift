/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  MusicCache.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 04/01/2017.
 *  Copyright © 2017 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import Foundation
import SpriteKit
import AudioToolbox

extension GameScene {
    class MusicCache {
        //Cache
        private let cache = NSCache<NSString, SKTexture>()
        
        func getCached(key: String) -> SKTexture {
            // found it, return it
            if let cachedVersion = cache.object(forKey: key as NSString) {
                return cachedVersion
            }
                
                // build it, return it
            else {
                let texture = SKTexture(imageNamed: key)
                cache.setObject(texture, forKey: key as NSString)
                return texture
            }
        }
    }
}
