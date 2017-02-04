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
        private let title = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        private let titleBar = SKSpriteNode(color: UIColor.cyan, size: CGSize(width: 500, height: 86))
        
        private let customiseLabel   = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private let customiseButton  = SKSpriteNode()
        
        private let leaderboardLabel  = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private let leaderboardButton = SKSpriteNode()
        
        private let optionsLabel   = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private let optionsButton  = SKSpriteNode()
        
        private let aboutLabel   = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private let aboutButton    = SKSpriteNode()
        
        private let player: Player!
        
        private let screenWidth: Int!
        private let screenHeight: Int!
        
        init (w: Int, h: Int, p: Player) {
            player = p
            screenWidth = w
            screenHeight = h
            
            super.init()
            
            LocalisedStringMachine.changeLanguage(lan: .english)
            
            title.text = LocalisedStringMachine.getString(string: "Rocks")
            title.fontSize = 50
            title.horizontalAlignmentMode = .center
            title.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 0.88)
            title.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.82))
            title.zPosition = 1
            addChild(title)
            
            titleBar.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.85))
            titleBar.color    = UIColor(red: 0.35686275, green: 0.1372549, blue: 0.2, alpha: 0.5)
            titleBar.zPosition = 0
            addChild(titleBar)
            
            customiseLabel.text = LocalisedStringMachine.getString(string: "customise ship")
            customiseLabel.fontSize = 28
            customiseLabel.horizontalAlignmentMode = .center
            customiseLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            customiseLabel.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.35))
            addChild(customiseLabel)
            
            customiseButton.name = String("customiseButton")
            customiseButton.size = CGSize(width: w * 2, height: 52)
            customiseButton.color = UIColor.clear
            customiseButton.position = CGPoint(x: 0, y: Int(Double(screenHeight) * 0.35))
            addChild(customiseButton)
            
            leaderboardLabel.text = LocalisedStringMachine.getString(string: "leaderboard")
            leaderboardLabel.fontSize = 28
            leaderboardLabel.horizontalAlignmentMode = .center
            leaderboardLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            leaderboardLabel.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.27))
            addChild(leaderboardLabel)
            
            leaderboardButton.name = String("leaderboardButton")
            leaderboardButton.size = CGSize(width: w * 2, height: 52)
            leaderboardButton.color = UIColor.clear
            leaderboardButton.position = CGPoint(x: 0, y: Int(Double(screenHeight) * 0.27))
            addChild(leaderboardButton)
            
            optionsLabel.text = LocalisedStringMachine.getString(string: "options")
            optionsLabel.fontSize = 28
            optionsLabel.horizontalAlignmentMode = .center
            optionsLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            optionsLabel.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.19))
            addChild(optionsLabel)
            
            optionsButton.name = String("optionsButton")
            optionsButton.size = CGSize(width: w * 2, height: 52)
            optionsButton.color = UIColor.clear
            optionsButton.position = CGPoint(x: 0, y: Int(Double(screenHeight) * 0.19))
            addChild(optionsButton)
            
            aboutLabel.text = LocalisedStringMachine.getString(string: "about")
            aboutLabel.fontSize = 28
            aboutLabel.horizontalAlignmentMode = .center
            aboutLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            aboutLabel.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.11))
            addChild(aboutLabel)
            
            aboutButton.name = String("aboutButton")
            aboutButton.size = CGSize(width: w * 2, height: 52)
            aboutButton.color = UIColor.clear
            aboutButton.position = CGPoint(x: 0, y: Int(Double(screenHeight) * 0.11))
            addChild(aboutButton)
            
        }
        
        // :(
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            
        }
    }
}
