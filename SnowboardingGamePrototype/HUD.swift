/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  HUD.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    
    class HUD {
        private let HUDContainer       = SKNode()
        
        // pause button
        private let pauseButtonNode    = SKSpriteNode()
        private let pauseLabelNode     = SKLabelNode()
        
        // pause / help screen
        private let pauseAlertNode     = SKLabelNode()
        private let helpImageOne       = SKSpriteNode()
        private let helpImageTwo       = SKSpriteNode()
        private let helpImageThree     = SKSpriteNode()
        private let helpLabelOne       = SKLabelNode()
        private let helpLabelTwo       = SKLabelNode()
        private let helpLabelThree     = SKLabelNode()
        
        // in-game ui
        private let healthBarNode      = SKLabelNode(fontNamed: "Arial")
        private let ammoBarNode        = SKLabelNode(fontNamed: "Arial")
        private let thisScoreLabelNode = SKLabelNode(fontNamed: "Arial")
        private let bestScoreLabelNode = SKLabelNode(fontNamed: "Arial")
        
        // game over screen
        private let deathLabelNode     = SKLabelNode(fontNamed: "Arial")
        private let finalScoreNode     = SKLabelNode(fontNamed: "Arial")
        private let highScoreNode      = SKLabelNode (fontNamed: "Arial")
        private var over               = false

        
        // hold reference to player
        private var player: Player!
        
        
        func initialise (width: Int, height: Int, player: Player) -> SKNode {
            self.player = player
        
            // health bar
            healthBarNode.name                    = String("Label")
            healthBarNode.text                    = String("")
            for _ in 0...player.getHealth() { healthBarNode.text?.append("I") }
            healthBarNode.fontSize                = 24
            healthBarNode.horizontalAlignmentMode = .right
            healthBarNode.position                = CGPoint(x: width-10, y: height-24)
            healthBarNode.fontColor               = UIColor.red
            HUDContainer.addChild(healthBarNode)
            
            // ammo bar
            ammoBarNode.name                            = String("Label")
            ammoBarNode.text                            = String("")
            for _ in 0...player.getAmmo() { ammoBarNode.text?.append("I") }
            ammoBarNode.fontSize                        = 24
            ammoBarNode.horizontalAlignmentMode         = .left
            ammoBarNode.position                        = CGPoint(x: 10, y: height-24)
            ammoBarNode.fontColor                       = UIColor.cyan
            HUDContainer.addChild(ammoBarNode)
            
            // best score
            bestScoreLabelNode.name                     = String("Label")
            bestScoreLabelNode.text                     = String("27543") // previous best icloud score should be visible in game
            bestScoreLabelNode.fontSize                 = 20
            bestScoreLabelNode.horizontalAlignmentMode  = .left
            bestScoreLabelNode.position                 = CGPoint(x:6, y:28)
            bestScoreLabelNode.fontColor                = UIColor.lightGray
            HUDContainer.addChild(bestScoreLabelNode)
            
            // current score
            thisScoreLabelNode.name                     = String("Label")
            thisScoreLabelNode.text                     = String(0)
            thisScoreLabelNode.fontSize                 = 20
            thisScoreLabelNode.horizontalAlignmentMode  = .left
            thisScoreLabelNode.position                 = CGPoint(x:6, y:6)
            thisScoreLabelNode.fontColor                = UIColor.gray
            HUDContainer.addChild(thisScoreLabelNode)
            
            // make death label
            deathLabelNode.name                         = String("Label")
            deathLabelNode.text                         = String("GAME OVER")
            deathLabelNode.fontSize                     = 48
            deathLabelNode.horizontalAlignmentMode      = .center
            deathLabelNode.fontColor                    = UIColor.clear
            deathLabelNode.position                     = CGPoint(x: width / 2, y: height / 2)
            HUDContainer.addChild(deathLabelNode)
            
            // make death score label
            finalScoreNode.name                         = String("Label")
            finalScoreNode.fontSize                     = 24
            finalScoreNode.horizontalAlignmentMode      = .center
            finalScoreNode.fontColor                    = UIColor.clear
            finalScoreNode.position                     = CGPoint(x: width / 2, y: height / 2 - 40)
            HUDContainer.addChild(finalScoreNode)
            
            highScoreNode.name                          = String("Label")
            highScoreNode.text                          = String ("[iCloud score]")
            highScoreNode.fontSize                      = 24
            highScoreNode.horizontalAlignmentMode       = .center
            highScoreNode.fontColor                     = UIColor.clear
            highScoreNode.position                      = CGPoint(x: width / 2, y: height / 2 - 68)
            HUDContainer.addChild(highScoreNode)
            
            // make pause button
            pauseButtonNode.position                    = CGPoint(x: width/2, y: 6)
            pauseButtonNode.size                        = CGSize(width: width, height: 225)
            pauseButtonNode.name                        = "PauseButton"
            HUDContainer.addChild(pauseButtonNode)
            
            pauseLabelNode.name                         = String("Label")
            pauseLabelNode.position                     = CGPoint(x: width/2,y: 6)
            pauseLabelNode.text                         = "I I"
            pauseLabelNode.fontSize                     = 42
            pauseLabelNode.horizontalAlignmentMode      = .center
            pauseLabelNode.name                         = "PauseLabel"
            HUDContainer.addChild(pauseLabelNode)
            
            // help screen
            helpImageOne.texture                        = SKTexture(imageNamed: String("HealthPickup"))
            helpImageOne.position                       = CGPoint(x: width / 3, y: height / 2 - 36)
            helpImageOne.size                           = CGSize(width: 24, height: 24)
            helpImageTwo.texture                        = SKTexture(imageNamed: String("AmmoPickup"))
            helpImageTwo.position                       = CGPoint(x: width / 3, y: height / 2 - 60)
            helpImageTwo.size                           = CGSize(width: 24, height: 24)
            helpImageThree.texture                      = SKTexture(imageNamed: String("PointsPickup"))
            helpImageThree.position                     = CGPoint(x: width / 3, y: height / 2 - 84)
            helpImageThree.size                         = CGSize(width: 24, height: 24)
            
            HUDContainer.addChild(helpImageOne)
            HUDContainer.addChild(helpImageTwo)
            HUDContainer.addChild(helpImageThree)
            
            helpImageOne.run(SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0))
            helpImageTwo.run(SKAction.colorize(with: UIColor.cyan, colorBlendFactor: 1.0, duration: 0))
            helpImageThree.run(SKAction.colorize(with: UIColor.white, colorBlendFactor: 1.0, duration: 0))
            
            helpImageOne.run(SKAction.removeFromParent())
            helpImageTwo.run(SKAction.removeFromParent())
            helpImageThree.run(SKAction.removeFromParent())
            
            helpLabelOne.text                           = String("health")
            helpLabelOne.position                       = CGPoint(x: (width / 3) + 46, y : height / 2 - 44)
            helpLabelOne.horizontalAlignmentMode        = .left
            helpLabelTwo.text                           = String("ammo")
            helpLabelTwo.position                       = CGPoint(x: (width / 3) + 46, y : height / 2 - 70)
            helpLabelTwo.horizontalAlignmentMode        = .left
            helpLabelThree.text                         = String("points")
            helpLabelThree.position                     = CGPoint(x: (width / 3) + 46, y : height / 2 - 94)
            helpLabelThree.horizontalAlignmentMode      = .left
            
            HUDContainer.addChild(helpLabelOne)
            HUDContainer.addChild(helpLabelTwo)
            HUDContainer.addChild(helpLabelThree)
            
            // pause alert
            pauseAlertNode.name                         = String("Label")
            pauseAlertNode.text                         = String("PAUSED")
            pauseAlertNode.position                     = CGPoint(x: width / 2, y: height / 2)
            pauseAlertNode.fontSize                     = 68
            pauseAlertNode.horizontalAlignmentMode      = .center
            pauseAlertNode.fontColor                    = UIColor.clear
            HUDContainer.addChild(pauseAlertNode);
            
            HUDContainer.zPosition = 1
            
            return HUDContainer
        }
        
        func gameEnded () {
            over = true
        }
        
        func reset () {
//          score.reset()
            over = false
        }
        
        func update (state: Bool, score: Int) {
            // update score label
            thisScoreLabelNode.text = String(score)
            
            // update health and ammo bars
            healthBarNode.text = String("")
            ammoBarNode.text = String("")
            for i in 0...player.getHealth() { if (i > 0) {healthBarNode.text?.append("I")} }
            for i in 0...player.getAmmo() { if (i > 0) {ammoBarNode.text?.append("I")} }
            
            if (state) {
                if (!over) {
                    pauseAlertNode.fontColor = UIColor.white
                    pauseLabelNode.text      = "resume"
                    pauseLabelNode.fontSize  = 28
                    
                    helpLabelOne.fontColor   = UIColor.white
                    helpLabelTwo.fontColor   = UIColor.white
                    helpLabelThree.fontColor = UIColor.white
                    
                    HUDContainer.addChild (helpImageOne)
                    HUDContainer.addChild (helpImageTwo)
                    HUDContainer.addChild (helpImageThree)
                
                }
            }
                
            else {
                pauseAlertNode.fontColor = UIColor.clear
                pauseLabelNode.text      = "I I"
                pauseLabelNode.fontSize  = 50
                
                helpLabelOne.fontColor   = UIColor.clear
                helpLabelTwo.fontColor   = UIColor.clear
                helpLabelThree.fontColor = UIColor.clear
                
                helpImageOne.run    (SKAction.removeFromParent())
                helpImageTwo.run    (SKAction.removeFromParent())
                helpImageThree.run  (SKAction.removeFromParent())
            }
            
            // update game over label
            if (over) {
                // show death screen
                deathLabelNode.fontColor = UIColor.white
                finalScoreNode.text      = String(score)
                finalScoreNode.fontColor = UIColor.white
                highScoreNode.fontColor  = UIColor.white
                
                // hide everything else
                bestScoreLabelNode.fontColor = UIColor.clear
                thisScoreLabelNode.fontColor = UIColor.clear
                pauseLabelNode.fontColor     = UIColor.clear
                healthBarNode.fontColor      = UIColor.clear
                ammoBarNode.fontColor        = UIColor.clear
            }
                
            else {
                // hide death screen
                deathLabelNode.fontColor = UIColor.clear
                finalScoreNode.fontColor = UIColor.clear
                highScoreNode.fontColor  = UIColor.clear
                
                // show everything else
                bestScoreLabelNode.fontColor = UIColor.gray
                thisScoreLabelNode.fontColor = UIColor.lightGray
                pauseLabelNode.fontColor     = UIColor.lightGray
                healthBarNode.fontColor      = UIColor.red
                ammoBarNode.fontColor        = UIColor.cyan
            }
        }
    }
}
