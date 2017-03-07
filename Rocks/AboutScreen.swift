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
    
        private var versionTitleY: CGFloat!
        private var versionTitle = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        
        private var versionNumberY: CGFloat!
        private var versionNumber = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        
        private var authorsTitleY: CGFloat!
        private var authorsTitle = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        
        private var ryanCreditY: CGFloat!
        private var ryanCredit = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        
        private var dannyCreditY: CGFloat!
        private var dannyCredit = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        
        private var musicTitleY: CGFloat!
        private var musicTitle = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        
        private var jamesCreditY: CGFloat!
        private var jamesCredit = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        
        
        private var backLabel = SKLabelNode()
        private var backButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 200, height: 100))
        
        private var screenWidth: CGFloat!
        private var screenHeight: CGFloat!
        
        init (w: Int, h: Int, p: Player) {
        
            versionTitleY  = CGFloat(Double(h) * 0.42)
            versionNumberY = CGFloat(Double(h) * 0.38)
            authorsTitleY  = CGFloat(Double(h) * 0.28)
            ryanCreditY    = CGFloat(Double(h) * 0.24)
            dannyCreditY   = CGFloat(Double(h) * 0.20)
            musicTitleY    = CGFloat(Double(h) * 0.12)
            jamesCreditY   = CGFloat(Double(h) * 0.08)
            
            screenWidth = CGFloat(w)
            screenHeight = CGFloat(h)
            
            super.init()
            versionTitle.text = String("version")
            versionTitle.fontSize = 42
            versionTitle.horizontalAlignmentMode = .center
            versionTitle.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            versionTitle.position = CGPoint(x: w / 2, y: 0)
            addChild(versionTitle)
            
            versionNumber.text = String("Beta 3.1")
            versionNumber.fontSize = 20
            versionNumber.horizontalAlignmentMode = .center
            versionNumber.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            versionNumber.position = CGPoint(x: w / 2, y: 0)
            addChild(versionNumber)
            
            authorsTitle.text = String("programmers")
            authorsTitle.fontSize = 42
            authorsTitle.horizontalAlignmentMode = .center
            authorsTitle.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            authorsTitle.position = CGPoint(x: w / 2, y: 0)
            addChild(authorsTitle)
            
            ryanCredit.text = String("Ryan Needham")
            ryanCredit.fontSize = 20
            ryanCredit.horizontalAlignmentMode = .center
            ryanCredit.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            ryanCredit.position = CGPoint(x: w / 2, y: 0)
            addChild(ryanCredit)
            
            dannyCredit.text = String("Danny Wilson")
            dannyCredit.fontSize = 20
            dannyCredit.horizontalAlignmentMode = .center
            dannyCredit.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            dannyCredit.position = CGPoint(x: w / 2, y: 0)
            addChild(dannyCredit)
            
            musicTitle.text = String("music")
            musicTitle.fontSize = 42
            musicTitle.horizontalAlignmentMode = .center
            musicTitle.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            musicTitle.position = CGPoint(x: w / 2, y: 0)
            addChild(musicTitle)
            
            jamesCredit.text = String("James Sutherland")
            jamesCredit.fontSize = 20
            jamesCredit.horizontalAlignmentMode = .center
            jamesCredit.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            jamesCredit.position = CGPoint(x: w / 2, y: 0)
            addChild(jamesCredit)
            
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
        
        func hide () {
            isHidden       = true
            versionTitleY  = 0
            versionNumberY = 0
            authorsTitleY  = 0
            ryanCreditY    = 0
            dannyCreditY   = 0
            musicTitleY    = 0
            jamesCreditY   = 0
        }
        
        func show () {
            isHidden       = false
            versionTitleY  = CGFloat(Double(screenHeight) * 0.42)
            versionNumberY = CGFloat(Double(screenHeight) * 0.38)
            authorsTitleY  = CGFloat(Double(screenHeight) * 0.28)
            ryanCreditY    = CGFloat(Double(screenHeight) * 0.24)
            dannyCreditY   = CGFloat(Double(screenHeight) * 0.20)
            musicTitleY    = CGFloat(Double(screenHeight) * 0.12)
            jamesCreditY   = CGFloat(Double(screenHeight) * 0.08)
        }
        
        func update () {
            let speed: CGFloat = 0.16
            
            // VERSION TITLE
            if (versionTitle.position.y < versionTitleY) { versionTitle.position.y += (versionTitleY - versionTitle.position.y) * speed }
            if (versionTitle.position.y > versionTitleY) { versionTitle.position.y -= (versionTitle.position.y - versionTitleY) * speed}
            
            // VERSION NUMBER
            if (versionNumber.position.y < versionNumberY) { versionNumber.position.y += (versionNumberY - versionNumber.position.y) * speed}
            if (versionNumber.position.y > versionNumberY) { versionNumber.position.y -= (versionNumber.position.y - versionNumberY) * speed}
            
            // AUTHOR TITLE
            if (authorsTitle.position.y < authorsTitleY) { authorsTitle.position.y += (authorsTitleY - authorsTitle.position.y) * speed}
            if (authorsTitle.position.y > authorsTitleY) { authorsTitle.position.y -= (authorsTitle.position.y - authorsTitleY) * speed}
            
            // RYAN CREDIT
            if (ryanCredit.position.y < ryanCreditY) { ryanCredit.position.y += (ryanCreditY - ryanCredit.position.y) * speed}
            if (ryanCredit.position.y > ryanCreditY) { ryanCredit.position.y -= (ryanCredit.position.y - ryanCreditY) * speed}
            
            // DANNY CREDIT
            if (dannyCredit.position.y < dannyCreditY) { dannyCredit.position.y += (dannyCreditY - dannyCredit.position.y) * speed}
            if (dannyCredit.position.y > dannyCreditY) { dannyCredit.position.y -= (dannyCredit.position.y - dannyCreditY) * speed}
            
            // Music Title
            if (musicTitle.position.y < musicTitleY) { musicTitle.position.y += (musicTitleY - musicTitle.position.y) * speed}
            if (musicTitle.position.y > musicTitleY) { musicTitle.position.y -= (musicTitle.position.y - musicTitleY) * speed}
            
            // DANNY CREDIT
            if (jamesCredit.position.y < jamesCreditY) { jamesCredit.position.y += (jamesCreditY - jamesCredit.position.y) * speed}
            if (jamesCredit.position.y > jamesCreditY) { jamesCredit.position.y -= (jamesCredit.position.y - jamesCreditY) * speed}
            
        }
    }
}
