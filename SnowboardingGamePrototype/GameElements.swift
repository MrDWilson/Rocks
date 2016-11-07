//
//  GameElements.swift
//  SnowboardingGamePrototype
//
//  Created by user on 07/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit

// Collision Bit Mask
struct collision {
    static let player:UInt32 = 0x00
    static let asteroid:UInt32 = 0x01
}

extension GameScene {

    func spawnPlayer () {
        player = SKSpriteNode(color: UIColor.gray, size: CGSize(width: 24, height: 24))
        
        // Give name, position and texture
        player.name = "PlayerOne"
        player.position = CGPoint(x: self.size.width / 2 , y: 60)
        player.texture = SKTexture(imageNamed: "Spaceship") // add spaceship texture to sprite
        
        // Give physics
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        player.physicsBody?.categoryBitMask = collision.player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = collision.asteroid
        
        // add to scene
        addChild(player);
    }
    
    func spawnAsteroid () {
        var actionArray = [SKAction]()
        let asteroid    = SKSpriteNode(color: UIColor.brown, size: CGSize(width: 10, height: 10))
        let speed       = 5
        let size        = Int(arc4random_uniform(10))

        // Give name, size and position
        asteroid.name = "asteroid"
        asteroid.size.width = asteroid.size.width * CGFloat(size)
        asteroid.size.height = asteroid.size.height * CGFloat(size)
        asteroid.position = CGPoint(x: CGFloat(Int(arc4random_uniform(UInt32(self.size.width)))), y: self.size.height + asteroid.size.height)
        asteroid.texture = SKTexture(imageNamed: "rock")

        // Give physics components
        asteroid.physicsBody?.isDynamic = true
        asteroid.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: asteroid.size.width, height: asteroid.size.height))
        asteroid.physicsBody?.categoryBitMask = collision.asteroid
        asteroid.physicsBody?.collisionBitMask = 0
        
        // Give motion
        actionArray.append(SKAction.move(to: CGPoint(x: asteroid.position.x, y: -asteroid.size.height), duration: TimeInterval(speed)))
        actionArray.append(SKAction.removeFromParent());
        asteroid.run(SKAction.sequence(actionArray))
       
        // add to scene
        addChild(asteroid)
    }
}
