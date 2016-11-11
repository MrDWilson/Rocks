//
//  Cache.swift
//  SnowboardingGamePrototype
//
//  Created by Danny Wilson on 11/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    class Cache {
    
        //Cache
        private let cache = NSCache<NSString, SKTexture>()
        private var asteroidCache = SKTexture()
        
        func getCached(key: String) -> SKTexture {
            if let cachedVersion = cache.object(forKey: key as NSString) {
                // use the cached version
                asteroidCache = cachedVersion
                return asteroidCache
            } else {
                // create it from scratch then store in the cache
                asteroidCache = SKTexture(imageNamed: "Asteroid")
                cache.setObject(asteroidCache, forKey: key as NSString)
                return asteroidCache
            }
        }
        
    }
    
}
