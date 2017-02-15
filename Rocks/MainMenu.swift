/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  MainMenu.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class MainMenu: SKNode {
        private var titleY: CGFloat!
        private let title    = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        private let titleBar = SKSpriteNode(color: UIColor.cyan, size: CGSize(width: 500, height: 86))
        
        private var customiseY: CGFloat!
        private let customiseLabel   = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private let customiseButton  = SKSpriteNode()
        
        private var leaderboardY: CGFloat!
        private let leaderboardLabel  = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private let leaderboardButton = SKSpriteNode()
        
        private var optionsY: CGFloat!
        private let optionsLabel   = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private let optionsButton  = SKSpriteNode()
        
        private var aboutY: CGFloat!
        private let aboutLabel     = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private let aboutButton    = SKSpriteNode()
        
        private let player: Player!
        
        private let screenWidth: Int!
        private let screenHeight: Int!
        
        init (w: Int, h: Int, p: Player) {
            player       = p
            screenWidth  = w
            screenHeight = h
            
            titleY       = CGFloat(Double(screenHeight) * 0.82)
            customiseY   = CGFloat(Double(screenHeight) * 0.35)
            leaderboardY = CGFloat(Double(screenHeight) * 0.27)
            optionsY     = CGFloat(Double(screenHeight) * 0.19)
            aboutY       = CGFloat(Double(screenHeight) * 0.11)
            
            super.init()
            
            LocalisedStringMachine.changeLanguage(lan: .english)
            
            title.text = LocalisedStringMachine.getString(string: "Rocks")
            title.fontSize = 50
            title.horizontalAlignmentMode = .center
            title.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 0.88)
            title.position = CGPoint(x: w / 2, y: h)
            title.zPosition = 1
            addChild(title)
            
            titleBar.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.85))
            titleBar.color    = UIColor(red: 0.35686275, green: 0.1372549, blue: 0.2, alpha: 0.5)
            titleBar.zPosition = 0
            //addChild(titleBar)
            
            customiseLabel.text = LocalisedStringMachine.getString(string: "customise ship")
            customiseLabel.fontSize = 28
            customiseLabel.horizontalAlignmentMode = .center
            customiseLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            customiseLabel.position = CGPoint(x: w / 2, y: 0)
            addChild(customiseLabel)
            
            customiseButton.name = String("customiseButton")
            customiseButton.size = CGSize(width: w * 2, height: 52)
            customiseButton.color = UIColor.clear // UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.2)
            customiseButton.position = CGPoint(x: 0, y: 0)
            addChild(customiseButton)
            
            leaderboardLabel.text = LocalisedStringMachine.getString(string: "leaderboard")
            leaderboardLabel.fontSize = 28
            leaderboardLabel.horizontalAlignmentMode = .center
            leaderboardLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            leaderboardLabel.position = CGPoint(x: w / 2, y: 0)
            addChild(leaderboardLabel)
            
            leaderboardButton.name = String("leaderboardButton")
            leaderboardButton.size = CGSize(width: w * 2, height: 52)
            leaderboardButton.color = UIColor.clear // UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.2)
            leaderboardButton.position = CGPoint(x: 0, y: 0)
            addChild(leaderboardButton)
            
            optionsLabel.text = LocalisedStringMachine.getString(string: "options")
            optionsLabel.fontSize = 28
            optionsLabel.horizontalAlignmentMode = .center
            optionsLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            optionsLabel.position = CGPoint(x: w / 2, y: 0)
            addChild(optionsLabel)
            
            optionsButton.name = String("optionsButton")
            optionsButton.size = CGSize(width: w * 2, height: 52)
            optionsButton.color = UIColor.clear // UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.2)
            optionsButton.position = CGPoint(x: 0, y: 0)
            addChild(optionsButton)
            
            aboutLabel.text = LocalisedStringMachine.getString(string: "about")
            aboutLabel.fontSize = 28
            aboutLabel.horizontalAlignmentMode = .center
            aboutLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            aboutLabel.position = CGPoint(x: w / 2, y: 0)
            addChild(aboutLabel)
            
            aboutButton.name = String("aboutButton")
            aboutButton.size = CGSize(width: w * 2, height: 52)
            aboutButton.color = UIColor.clear // UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.2)
            aboutButton.position = CGPoint(x: 0, y: 0)
            addChild(aboutButton)
            
        }
        
        // :(
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func hide () {
            isHidden     = true
            titleY       = CGFloat(screenHeight)
            customiseY   = 0
            leaderboardY = 0
            optionsY     = 0
            aboutY       = 0
        }
        
        func show () {
            isHidden     = false
            titleY       = CGFloat(Double(screenHeight) * 0.82)
            customiseY   = CGFloat(Double(screenHeight) * 0.35)
            leaderboardY = CGFloat(Double(screenHeight) * 0.27)
            optionsY     = CGFloat(Double(screenHeight) * 0.19)
            aboutY       = CGFloat(Double(screenHeight) * 0.11)
        }
        
        func update () {
            let speed: CGFloat = 0.16
        
            // TITLE
            if (title.position.y < titleY) { title.position.y += (titleY - title.position.y) * speed }
            if (title.position.y > titleY) { title.position.y -= (title.position.y - titleY) * speed }
        
            // CUSTOMISE MENU
            if (customiseLabel.position.y < customiseY) {
                customiseLabel.position.y  += (customiseY - customiseLabel.position.y) * speed
                customiseButton.position.y += (customiseY - customiseButton.position.y) * speed
            }
            
            if (customiseLabel.position.y > customiseY) {
                customiseLabel.position.y  -= (customiseLabel.position.y - customiseY) * speed
                customiseButton.position.y -= (customiseButton.position.y - customiseY) * speed
            }
        
            // Leaderboard
            if (leaderboardLabel.position.y < leaderboardY) {
                leaderboardLabel.position.y  += (leaderboardY - leaderboardLabel.position.y) * speed
                leaderboardButton.position.y += (leaderboardY - leaderboardButton.position.y) * speed
            }
            
            if (leaderboardLabel.position.y > leaderboardY) {
                leaderboardLabel.position.y  -= (leaderboardLabel.position.y - leaderboardY) * speed
                leaderboardButton.position.y -= (leaderboardButton.position.y - leaderboardY) * speed
            }

            // Options
            if (optionsLabel.position.y < optionsY) {
                optionsLabel.position.y  += (optionsY - optionsLabel.position.y) * speed
                optionsButton.position.y += (optionsY - optionsButton.position.y) * speed
            }
            
            if (optionsLabel.position.y > optionsY) {
                optionsLabel.position.y  -= (optionsLabel.position.y - optionsY) * speed
                optionsButton.position.y -= (optionsButton.position.y - optionsY) * speed
            }

            // About
            if (aboutLabel.position.y < aboutY) {
                aboutLabel.position.y  += (aboutY - aboutLabel.position.y) * speed
                aboutButton.position.y += (aboutY - aboutButton.position.y) * speed
            }
            
            if (aboutLabel.position.y > aboutY) {
                aboutLabel.position.y  -= (aboutLabel.position.y - aboutY) * speed
                aboutButton.position.y -= (aboutButton.position.y - aboutY) * speed
            }

        }
    }
}
