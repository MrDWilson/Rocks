/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  OptionsScreen.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class OptionsScreen: SKNode {
        private var backLabel  = SKLabelNode()
        private var backButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 200, height: 100))
        
        init (w: Int, h: Int, p: Player) {
            super.init()
            
            backLabel.text = String("back")
            backLabel.horizontalAlignmentMode = .left
            backLabel.position = CGPoint(x: 10, y: h - 50)
            addChild(backLabel)
            
            backButton.name = String("back")
            backButton.position = CGPoint(x: 10, y: h - 10)
            addChild(backButton)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            
        }
    }
}
