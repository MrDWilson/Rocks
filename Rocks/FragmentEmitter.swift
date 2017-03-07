//
//  FragmentEmitter.swift
//  Rocks
//
//  Created by user on 15/02/2017.
//  Copyright © 2017 Ryan Needham. All rights reserved.
//

import SpriteKit

extension GameScene {
    class FragmentEmitter {
        private var fragments = [AsteroidFragment]()
        private var fragmentCount = 10
        private var position: CGPoint!
        
        private let screenWidth: CGFloat!
        
        // spit particles at ship on menu
        
        init (w: CGFloat) {
            position = CGPoint(x: 0, y: 0)
        
            screenWidth = w
        
            for _ in 0 ... fragmentCount {
                fragments.append(AsteroidFragment())
            }
        }
        
        func setPosition (x: CGFloat, y: CGFloat) { position = CGPoint(x:x, y:y) }
        
        func add (to: SKNode) {
            fragments.forEach { to.addChild($0.getSprite()); $0.boom() }
        }
        
        func update () {
            fragments.forEach { $0.update() }
            
            fragments.forEach {
                if ($0.getSprite().position.y < -20) {
                    $0.getSprite().position.x = CGFloat(0 + Int(arc4random_uniform(UInt32(screenWidth))))
                    $0.getSprite().position.y = position.y
                    //$0.boom()
                }
            }
            
        }
    }
}
