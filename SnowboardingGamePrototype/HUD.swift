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
        private let deathLabelNode = SKLabelNode(fontNamed: "Arial")
        private let finalScoreNode = SKLabelNode(fontNamed: "Arial")
        private let timer          = Timer()
        private var over           = false
        
//      private let score = Counter()
        
        func initialise (width: Int, height: Int) -> SKNode {
            
            // make score label
            scoreLabelNode.text                     = String(save.getHighScore())
            scoreLabelNode.fontSize                 = 20
            scoreLabelNode.horizontalAlignmentMode  = .left
            scoreLabelNode.position                 = CGPoint(x:6, y:6)
            HUDContainer.addChild(scoreLabelNode)

            
            // make death label
            deathLabelNode.text                     = String("GAME OVER")
            deathLabelNode.fontSize                 = 48
            deathLabelNode.horizontalAlignmentMode  = .center
            deathLabelNode.fontColor                = UIColor.clear
            deathLabelNode.position                 = CGPoint(x: width / 2, y: height / 2)
            HUDContainer.addChild(deathLabelNode)
            
            // make death label
            finalScoreNode.fontSize                 = 24
            finalScoreNode.horizontalAlignmentMode  = .center
            finalScoreNode.fontColor                = UIColor.clear
            finalScoreNode.position                 = CGPoint(x: width / 2, y: height / 2 - 40)
            HUDContainer.addChild(finalScoreNode)
            
            // make pause button
            pauseButton.position                    = CGPoint(x: width/2, y: 6)
            pauseButton.size                        = CGSize(width: width-300, height: height-300)
            pauseButton.name                        = "PauseButton"
            HUDContainer.addChild(pauseButton)
            
            pauseLabelNode.position                 = CGPoint(x: width/2,y: 6)
            pauseLabelNode.text                     = "I I"
            pauseLabelNode.fontSize                 = 42
            pauseLabelNode.horizontalAlignmentMode  = .center
            pauseLabelNode.name                     = "PauseLabel"
            HUDContainer.addChild(pauseLabelNode)
            
            // pause alert
            pauseAlertNode.text                     = String("PAUSED")
            pauseAlertNode.position                 = CGPoint(x: width / 2, y: height / 2)
            pauseAlertNode.fontSize                 = 68
            pauseAlertNode.horizontalAlignmentMode  = .center
            pauseAlertNode.fontColor                = UIColor.clear
            HUDContainer.addChild(pauseAlertNode);
            
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
                
                scoreLabelNode.fontColor = UIColor.clear
                pauseLabelNode.fontColor = UIColor.clear
            }
                
            else {
                deathLabelNode.fontColor = UIColor.clear
                finalScoreNode.fontColor = UIColor.clear
                
                scoreLabelNode.fontColor = UIColor.white
                pauseLabelNode.fontColor = UIColor.white
            }
        }
    }
}
