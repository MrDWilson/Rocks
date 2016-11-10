import SpriteKit

extension GameScene {
    class Powerup {
        private let sprite = SKSpriteNode(color: UIColor.red, size: CGSize(width: 15, height: 15))
        private var actionArray = [SKAction]()
        private let speed = 5
        private let spin = Int(arc4random_uniform(5))
        private let size = Int(arc4random_uniform(10))
        
        func spawn (x: Int, y: Int) -> SKSpriteNode {
            
            // Give name, size and position
            sprite.name = "powerup"
            sprite.position = CGPoint(x: x, y: y)
            
            // Give graphics
            let ting = Int(arc4random_uniform(100))
            
            if (ting < 50) {
                sprite.texture = SKTexture(imageNamed: "PointsPickup")
            }
                
            else {
                sprite.texture = SKTexture(imageNamed: "PowerUp")
            }
            
            
            sprite.size.width = 20
            sprite.size.height = 20
            
            // Give physics components
            sprite.physicsBody?.isDynamic = true
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.categoryBitMask = collision.powerup
            sprite.physicsBody?.collisionBitMask = collision.player
            sprite.physicsBody?.contactTestBitMask = collision.powerup
            
            // Give motion
            //actionArray.append(SKAction.rotate(byAngle: 360, duration: TimeInterval(spin)))
            actionArray.append(SKAction.move(to: CGPoint(x: sprite.position.x, y: -sprite.size.height), duration: TimeInterval(speed)))
            
            actionArray.append(SKAction.removeFromParent()); // ISSUE: Asteroids aren't removing themselves to be garbage collected
            sprite.run(SKAction.sequence(actionArray))
            
            // add to scene
            return sprite
        }
    }
}
