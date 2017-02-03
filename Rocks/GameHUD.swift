/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  GameHUD.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class GameHUD: SKNode {
        private let numberMachine = NumberFormatter()
        
        // pause button
        private let pauseButtonNode    = SKSpriteNode()
        private let pauseLabelNode     = SKLabelNode()
        
        // in-game UI
        private let healthBarNode      = SKLabelNode(fontNamed: "Arial")
        private let healthBarLabel     = SKLabelNode(fontNamed: "Arial")
        private let ammoBarNode        = SKLabelNode(fontNamed: "Arial")
        private let ammoBarLabel       = SKLabelNode(fontNamed: "Arial")
        private let thisScoreLabelNode = SKLabelNode(fontNamed: "Arial")
        private let bestScoreLabelNode = SKLabelNode(fontNamed: "Arial")
        private var bestScore = 0
        
        // tutorial
        private let tutorial            = SKNode()
        private let shootingInstruction = SKLabelNode()
        private let movingInstruction   = SKLabelNode()
        
        private var player: Player!
        
        func flashAmmoBar   () { ammoBarNode.fontColor = UIColor.white }
        func flashHealthBar () { healthBarNode.fontColor = UIColor.white }
        func flashScore     () { thisScoreLabelNode.fontColor = UIColor.white }
        
        init (w: Int, h: Int, p: Player) {
            super.init()
            
            player = p
            
            numberMachine.numberStyle = .decimal
            
            // pause button
            pauseButtonNode.position                    = CGPoint(x: w/2, y: 6)
            pauseButtonNode.size                        = CGSize(width: w/4, height: 100)
            pauseButtonNode.name                        = "PauseButton"
            addChild(pauseButtonNode)
            
            pauseLabelNode.name                         = String("Label")
            pauseLabelNode.position                     = CGPoint(x: w/2,y: 6)
            pauseLabelNode.text                         = "I I"
            pauseLabelNode.fontSize                     = 42
            pauseLabelNode.horizontalAlignmentMode      = .center
            pauseLabelNode.name                         = "PauseLabel"
            addChild(pauseLabelNode)
            
            // health bar
            healthBarNode.name                    = String("Label")
            healthBarNode.text                    = String("")
            for _ in 0...player.getHealth() { healthBarNode.text?.append("I") }
            healthBarNode.fontSize                = 24
            healthBarNode.horizontalAlignmentMode = .right
            healthBarNode.position                = CGPoint(x: w-10, y: h-24)
            healthBarNode.fontColor               = UIColor.red
            addChild(healthBarNode)
            
            healthBarLabel.name                            = String("Label")
            healthBarLabel.text                            = LocalisedStringMachine.getString(string: "health")
            healthBarLabel.fontSize                        = 18
            healthBarLabel.horizontalAlignmentMode         = .right
            healthBarLabel.position                        = CGPoint(x: w-10, y: h-42)
            healthBarLabel.fontColor                       = UIColor.gray
            addChild(healthBarLabel)
            
            // ammo bar
            ammoBarNode.name                            = String("Label")
            ammoBarNode.text                            = String("")
            for _ in 0...player.getAmmo() { ammoBarNode.text?.append("I") }
            ammoBarNode.fontSize                        = 24
            ammoBarNode.horizontalAlignmentMode         = .left
            ammoBarNode.position                        = CGPoint(x: 10, y: h-24)
            ammoBarNode.fontColor                       = player.getLaserColour()
            addChild(ammoBarNode)
            
            ammoBarLabel.name                            = String("Label")
            ammoBarLabel.text                            = LocalisedStringMachine.getString(string: "ammo")
            ammoBarLabel.fontSize                        = 18
            ammoBarLabel.horizontalAlignmentMode         = .left
            ammoBarLabel.position                        = CGPoint(x: 10, y: h-42)
            ammoBarLabel.fontColor                       = UIColor.gray
            addChild(ammoBarLabel)
            
            // best score
            bestScoreLabelNode.name                     = String("Label")
            bestScoreLabelNode.text                     = String(String(describing: Save.getHighScore())) // previous best icloud score should be visible in game
            bestScoreLabelNode.fontSize                 = 20
            bestScoreLabelNode.horizontalAlignmentMode  = .left
            bestScoreLabelNode.position                 = CGPoint(x:6, y:28)
            bestScoreLabelNode.fontColor                = UIColor.lightGray
            addChild(bestScoreLabelNode)
            
            // current score
            thisScoreLabelNode.name                     = String("Label")
            thisScoreLabelNode.text                     = String(0)
            thisScoreLabelNode.fontSize                 = 20
            thisScoreLabelNode.horizontalAlignmentMode  = .left
            thisScoreLabelNode.position                 = CGPoint(x:6, y:6)
            thisScoreLabelNode.fontColor                = UIColor.gray
            addChild(thisScoreLabelNode)
            
            // TUTORIAL CODE
            shootingInstruction.name   = String("Label")
            shootingInstruction.text   = String("tap the screen to fire")
            shootingInstruction.fontSize = 30
            shootingInstruction.position = CGPoint(x: w/2, y: h/2)
            shootingInstruction.fontColor = UIColor.white
            shootingInstruction.alpha = 0.0
            
            movingInstruction.name = String("Label")
            movingInstruction.text = String("tilt your phone to move the ship")
            movingInstruction.fontSize = 30
            movingInstruction.position = CGPoint(x: w/2, y: h/2)
            movingInstruction.fontColor = UIColor.white
            movingInstruction.alpha = 0.0
            
            addChild(tutorial)

        }
        
        // why not just make the compiler add this...
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        func start () {
            if (!player.hasPlayedBefore()) {
                var shootingActionArray = [SKAction]()
                var movingActionArray = [SKAction]()
                
                shootingActionArray.append(SKAction.wait(forDuration: 2))
                shootingActionArray.append(SKAction.fadeAlpha(by: 1, duration: 1))
                shootingActionArray.append(SKAction.wait(forDuration: 4))
                shootingActionArray.append(SKAction.fadeAlpha(by: -1, duration: 1))
                shootingActionArray.append(SKAction.removeFromParent())
                
                movingActionArray.append(SKAction.wait(forDuration: 8))
                movingActionArray.append(SKAction.fadeAlpha(by: 1, duration: 1))
                movingActionArray.append(SKAction.wait(forDuration: 4))
                movingActionArray.append(SKAction.fadeAlpha(by: -1, duration: 1))
                movingActionArray.append(SKAction.removeFromParent())
                
                tutorial.addChild(shootingInstruction)
                tutorial.addChild(movingInstruction)
                shootingInstruction.run(SKAction.sequence(shootingActionArray))
                movingInstruction.run(SKAction.sequence(movingActionArray))
            }
        
        }
        
        func update () {
            // update score label
            //if (player.getScore() > bestScore) { bestScore = player.getScore() }
            if(player.getScore() > Save.getHighScore()) {
                bestScoreLabelNode.text = numberMachine.string(from: NSNumber(value: player.getScore()))
            } else {
                bestScoreLabelNode.text = numberMachine.string(from: NSNumber(value: Save.getHighScore()))

            }
            thisScoreLabelNode.text = numberMachine.string(from: NSNumber(value: player.getScore()))
            
            // update health and ammo bars
            healthBarNode.text = String("")
            ammoBarNode.text = String("")
            for i in 0...player.getHealth() { if (i > 0) {healthBarNode.text?.append("I")} }
            for i in 0...player.getAmmo() { if (i > 0) {ammoBarNode.text?.append("I")} }
            
            ammoBarNode.fontColor = player.getLaserColour()
            healthBarNode.fontColor = UIColor.red
            thisScoreLabelNode.fontColor = UIColor.gray
        }
    }
}
