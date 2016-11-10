//
//  HUD.swift
//  SnowboardingGamePrototype
//
//  Created by Ryan Needham on 08/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    class HUD {
        private let HUDContainer   = SKNode()
        private let pauseButton    = SKSpriteNode()
        private let pauseLabelNode = SKLabelNode()
        private let pauseAlertNode = SKLabelNode()
        private let scoreLabelNode = SKLabelNode(fontNamed: "Arial")
        private let previousBestLabelNode = SKLabelNode(fontNamed: "Arial")
        private let deathLabelNode = SKLabelNode(fontNamed: "Arial")
        private let finalScoreNode = SKLabelNode(fontNamed: "Arial")
        private let timer          = Timer()
        private var over           = false
        
        // high score
        private let highScoreNode = SKLabelNode (fontNamed: "Arial")
        
//      private let score = Counter()
        
        func initialise (width: Int, height: Int) -> SKNode {
            
            // make score label
            scoreLabelNode.name                     = String("Label")
            scoreLabelNode.text                     = String(0)
            scoreLabelNode.fontSize                 = 20
            scoreLabelNode.horizontalAlignmentMode  = .left
            scoreLabelNode.position                 = CGPoint(x:6, y:6)
            HUDContainer.addChild(scoreLabelNode)
            
            // make previous best label
            previousBestLabelNode.name                     = String("Label")
            previousBestLabelNode.text                     = String("27543") // previous best icloud score should be visible in game
            previousBestLabelNode.fontSize                 = 20
            previousBestLabelNode.horizontalAlignmentMode  = .left
            previousBestLabelNode.position                 = CGPoint(x:6, y:28)
            HUDContainer.addChild(previousBestLabelNode)

            
            // make death label
            deathLabelNode.name                     = String("Label")
            deathLabelNode.text                     = String("GAME OVER")
            deathLabelNode.fontSize                 = 48
            deathLabelNode.horizontalAlignmentMode  = .center
            deathLabelNode.fontColor                = UIColor.clear
            deathLabelNode.position                 = CGPoint(x: width / 2, y: height / 2)
            HUDContainer.addChild(deathLabelNode)
            
            // make death label
            finalScoreNode.name                     = String("Label")
            finalScoreNode.fontSize                 = 24
            finalScoreNode.horizontalAlignmentMode  = .center
            finalScoreNode.fontColor                = UIColor.clear
            finalScoreNode.position                 = CGPoint(x: width / 2, y: height / 2 - 40)
            HUDContainer.addChild(finalScoreNode)
            
            highScoreNode.name                     = String("Label")
            highScoreNode.text                     = String ("[iCloud score]")
            highScoreNode.fontSize                 = 24
            highScoreNode.horizontalAlignmentMode  = .center
            highScoreNode.fontColor                = UIColor.clear
            highScoreNode.position                 = CGPoint(x: width / 2, y: height / 2 - 68)
            HUDContainer.addChild(highScoreNode)
            
            // make pause button
            pauseButton.position                    = CGPoint(x: width/2, y: 6)
            pauseButton.size                        = CGSize(width: width, height: 225)
            pauseButton.name                        = "PauseButton"
            HUDContainer.addChild(pauseButton)
            
            pauseLabelNode.name                     = String("Label")
            pauseLabelNode.position                 = CGPoint(x: width/2,y: 6)
            pauseLabelNode.text                     = "I I"
            pauseLabelNode.fontSize                 = 42
            pauseLabelNode.horizontalAlignmentMode  = .center
            pauseLabelNode.name                     = "PauseLabel"
            HUDContainer.addChild(pauseLabelNode)
            
            // pause alert
            pauseAlertNode.name                     = String("Label")
            pauseAlertNode.text                     = String("PAUSED")
            pauseAlertNode.position                 = CGPoint(x: width / 2, y: height / 2)
            pauseAlertNode.fontSize                 = 68
            pauseAlertNode.horizontalAlignmentMode  = .center
            pauseAlertNode.fontColor                = UIColor.clear
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
            scoreLabelNode.text = String(score)
            
            if (state) {
                if (!over) {
                    pauseAlertNode.fontColor = UIColor.white
                    pauseLabelNode.text = "resume"
                    pauseLabelNode.fontSize = 28
                }
            }
                
            else {
                pauseAlertNode.fontColor = UIColor.clear
                pauseLabelNode.text = "I I"
                pauseLabelNode.fontSize = 50
            }
            
            // update game over label
            if (over) {
                deathLabelNode.fontColor = UIColor.white
                finalScoreNode.text = String(score)
                finalScoreNode.fontColor = UIColor.white
                highScoreNode.fontColor = UIColor.white
                
                previousBestLabelNode.fontColor = UIColor.clear
                scoreLabelNode.fontColor = UIColor.clear
                pauseLabelNode.fontColor = UIColor.clear
            }
                
            else {
                deathLabelNode.fontColor = UIColor.clear
                finalScoreNode.fontColor = UIColor.clear
                highScoreNode.fontColor = UIColor.clear
                
                previousBestLabelNode.fontColor = UIColor.white
                scoreLabelNode.fontColor = UIColor.white
                pauseLabelNode.fontColor = UIColor.white
            }
        }
    }
}
