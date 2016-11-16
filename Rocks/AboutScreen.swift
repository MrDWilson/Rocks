/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  AboutScreen.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class AboutScreen: SKNode {
        private var versionTitle = SKLabelNode()
        private var versionNumber = SKLabelNode(fontNamed: "Arial")
        
        private var authorsTitle = SKLabelNode()
        private var ryanCredit = SKLabelNode(fontNamed: "Arial")
        private var dannyCredit = SKLabelNode(fontNamed: "Arial")
        
        private var backLabel = SKLabelNode()
        private var backButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 200, height: 100))
        
        init (w: Int, h: Int, p: Player) {
            
            super.init()
            versionTitle.text = String("version")
            versionTitle.fontSize = 42
            versionTitle.horizontalAlignmentMode = .center
            versionTitle.fontColor = UIColor.white
            versionTitle.position = CGPoint(x: w / 2, y: Int(Double(h) * 0.42))
            addChild(versionTitle)
            
            versionNumber.text = String("Beta 3")
            versionNumber.fontSize = 20
            versionNumber.horizontalAlignmentMode = .center
            versionNumber.fontColor = UIColor.gray
            versionNumber.position = CGPoint(x: w / 2, y: Int(Double(h) * 0.38))
            addChild(versionNumber)
            
            authorsTitle.text = String("authors")
            authorsTitle.fontSize = 42
            authorsTitle.horizontalAlignmentMode = .center
            authorsTitle.fontColor = UIColor.white
            authorsTitle.position = CGPoint(x: w / 2, y: Int(Double(h) * 0.28))
            addChild(authorsTitle)
            
            ryanCredit.text = String("Ryan Needham")
            ryanCredit.fontSize = 20
            ryanCredit.horizontalAlignmentMode = .center
            ryanCredit.fontColor = UIColor.gray
            ryanCredit.position = CGPoint(x: w / 2, y: Int(Double(h) * 0.24))
            addChild(ryanCredit)
            
            dannyCredit.text = String("Danny Wilson")
            dannyCredit.fontSize = 20
            dannyCredit.horizontalAlignmentMode = .center
            dannyCredit.fontColor = UIColor.gray
            dannyCredit.position = CGPoint(x: w / 2, y: Int(Double(h) * 0.20))
            addChild(dannyCredit)
            
            backLabel.text = String("back")
            backLabel.horizontalAlignmentMode = .left
            backLabel.position = CGPoint(x: 10, y: h - 50)
            //addChild(backLabel)
            
            
            backButton.name = String("back")
            backButton.position = CGPoint(x: 10, y: h - 10)
            //addChild(backButton)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            
        }
    }
}
