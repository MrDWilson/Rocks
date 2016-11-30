/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  GameOverScreen.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class GameOverScreen: SKNode {
        private let numberMachine   = NumberFormatter()
        
        private let deathLabelNode     = SKLabelNode(fontNamed: "Arial")
        private let finalScoreNode     = SKLabelNode(fontNamed: "Arial")
        private let highScoreNode      = SKLabelNode (fontNamed: "Arial")
        private var highScore          = 0
        
        private let player: Player!
        
        init (w: Int, h: Int, p: Player) {
            player = p
            
            super.init()
            
            numberMachine.numberStyle = .decimal
            
            // make death label
            deathLabelNode.name                         = String("Label")
            deathLabelNode.text                         = String("GAME OVER")
            deathLabelNode.fontSize                     = 48
            deathLabelNode.horizontalAlignmentMode      = .center
            deathLabelNode.fontColor                    = UIColor.white
            deathLabelNode.position                     = CGPoint(x: w / 2, y: h / 2)
            addChild(deathLabelNode)
            
            // make death score label
            finalScoreNode.name                         = String("Label")
            finalScoreNode.fontSize                     = 24
            finalScoreNode.horizontalAlignmentMode      = .center
            finalScoreNode.fontColor                    = UIColor.lightGray
            finalScoreNode.position                     = CGPoint(x: w / 2, y: h / 2 - 40)
            addChild(finalScoreNode)
            
            highScoreNode.name                          = String("Label")
            highScoreNode.text                          = String ("[iCloud score]")
            highScoreNode.fontSize                      = 24
            highScoreNode.horizontalAlignmentMode       = .center
            highScoreNode.fontColor                     = UIColor.gray
            highScoreNode.position                      = CGPoint(x: w / 2, y: h / 2 - 68)
            addChild(highScoreNode)
        }
        
        // fuck off xcode
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            // save high scores
            if(player.getScore() > highScore) {
                highScore = player.getScore()
            }
            
            finalScoreNode.text =  numberMachine.string(from: NSNumber(value: player.getScore()))
            highScoreNode.text  =  numberMachine.string(from: NSNumber(value: Save.getHighScore()))
        }
    }
}
