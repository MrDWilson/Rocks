/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  TextureCache.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import Foundation
import SpriteKit

extension GameScene {
    class TextureCache {
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
