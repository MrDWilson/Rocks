/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  PauseMenu.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class PauseMenu: SKNode {
        
        // pause / help screen
        private let pauseAlertNode     = SKLabelNode()
        private let helpImageOne       = SKSpriteNode()
        private let helpImageTwo       = SKSpriteNode()
        private let helpImageThree     = SKSpriteNode()
        private let helpImageFour      = SKSpriteNode()
        private let helpImageFive      = SKSpriteNode()
        private let helpLabelOne       = SKLabelNode()
        private let helpLabelTwo       = SKLabelNode()
        private let helpLabelThree     = SKLabelNode()
        private let helpLabelFour      = SKLabelNode()
        private let helpLabelFive      = SKLabelNode()
        
        init (w: Int, h: Int, p: Player) {
            super.init()
            
            // help screen
            helpImageOne.texture                        = SKTexture(imageNamed: String("HealthPickup"))
            helpImageOne.position                       = CGPoint(x: w / 3, y: h / 2 - 36)
            helpImageOne.size                           = CGSize(width: 24, height: 24)
            helpImageTwo.texture                        = SKTexture(imageNamed: String("AmmoPickup"))
            helpImageTwo.position                       = CGPoint(x: w / 3, y: h / 2 - 76)
            helpImageTwo.size                           = CGSize(width: 24, height: 24)
            helpImageThree.texture                      = SKTexture(imageNamed: String("PointsPickup_1"))
            helpImageThree.position                     = CGPoint(x: w / 3, y: h / 2 - 116)
            helpImageThree.size                         = CGSize(width: 24, height: 24)
            helpImageFour.texture                       = SKTexture(imageNamed: String("PointsPickup_2"))
            helpImageFour.position                      = CGPoint(x: w / 3, y: h / 2 - 156)
            helpImageFour.size                          = CGSize(width: 24, height: 24)
            helpImageFive.texture                       = SKTexture(imageNamed: String("PointsPickup_3"))
            helpImageFive.position                      = CGPoint(x: w / 3, y: h / 2 - 196)
            helpImageFive.size                          = CGSize(width: 24, height: 24)
            
            addChild(helpImageOne)
            addChild(helpImageTwo)
            addChild(helpImageThree)
            addChild(helpImageFour)
            addChild(helpImageFive)
            
            helpImageOne.run   (SKAction.colorize(with: UIColor.red,        colorBlendFactor: 1.0, duration: 0))
            helpImageTwo.run   (SKAction.colorize(with: UIColor.cyan,       colorBlendFactor: 1.0, duration: 0))
            helpImageThree.run (SKAction.colorize(with: UIColor.gray,       colorBlendFactor: 1.0, duration: 0))
            helpImageFour.run  (SKAction.colorize(with: UIColor.lightGray,  colorBlendFactor: 1.0, duration: 0))
            helpImageFive.run  (SKAction.colorize(with: UIColor.white,      colorBlendFactor: 1.0, duration: 0))
            
            helpLabelOne.text                           = String("-  health")
            helpLabelOne.position                       = CGPoint(x: (w / 3) + 42, y : h / 2 - 46)
            helpLabelOne.horizontalAlignmentMode        = .left
            helpLabelTwo.text                           = String("-  ammo")
            helpLabelTwo.position                       = CGPoint(x: (w / 3) + 42, y : h / 2 - 86)
            helpLabelTwo.horizontalAlignmentMode        = .left
            helpLabelThree.text                         = String("-  25 points")
            helpLabelThree.position                     = CGPoint(x: (w / 3) + 42, y : h / 2 - 126)
            helpLabelThree.horizontalAlignmentMode      = .left
            helpLabelFour.text                          = String("-  50 points")
            helpLabelFour.position                      = CGPoint(x: (w / 3) + 42, y : h / 2 - 166)
            helpLabelFour.horizontalAlignmentMode       = .left
            helpLabelFive.text                          = String("-  100 points")
            helpLabelFive.position                      = CGPoint(x: (w / 3) + 42, y : h / 2 - 206)
            helpLabelFive.horizontalAlignmentMode       = .left
            
            addChild(helpLabelOne)
            addChild(helpLabelTwo)
            addChild(helpLabelThree)
            addChild(helpLabelFour)
            addChild(helpLabelFive)
            
            // pause alert
            pauseAlertNode.name                         = String("Label")
            pauseAlertNode.text                         = String("PAUSED")
            pauseAlertNode.position                     = CGPoint(x: w / 2, y: h / 2)
            pauseAlertNode.fontSize                     = 68
            pauseAlertNode.horizontalAlignmentMode      = .center
            pauseAlertNode.fontColor                    = UIColor.white
            addChild(pauseAlertNode);
        }
        
        // ?!?@?!$#$
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        
        func update () {
            
        }
    }
}
