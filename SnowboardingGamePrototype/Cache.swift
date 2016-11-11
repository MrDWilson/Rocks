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
        private var result = SKTexture()
        
        func getCached(key: String) -> SKTexture {
            switch key {
                case "asteroid":
                    if let cachedVersion = cache.object(forKey: key as NSString) {
                        // use the cached version
                        result = cachedVersion
                    } else {
                        // create it from scratch then store in the cache
                        result = SKTexture(imageNamed: "Asteroid")
                        cache.setObject(result, forKey: key as NSString)
                    }
                
                case "health":
                    if let cachedVersion = cache.object(forKey: key as NSString) {
                        // use the cached version
                        result = cachedVersion
                    } else {
                        // create it from scratch then store in the cache
                        result = SKTexture(imageNamed: "HealthPickup")
                        cache.setObject(result, forKey: key as NSString)
                    }
                
                case "ammo":
                    if let cachedVersion = cache.object(forKey: key as NSString) {
                        // use the cached version
                        result = cachedVersion
                    } else {
                        // create it from scratch then store in the cache
                        result = SKTexture(imageNamed: "AmmoPickup")
                        cache.setObject(result, forKey: key as NSString)
                    }
                
                case "points":
                    if let cachedVersion = cache.object(forKey: key as NSString) {
                        // use the cached version
                        result = cachedVersion
                    } else {
                        // create it from scratch then store in the cache
                        result = SKTexture(imageNamed: "PointsPickup")
                        cache.setObject(result, forKey: key as NSString)
                    }
                
                default:
                break
            }
            
            return result
        }
        
    }
    
}
