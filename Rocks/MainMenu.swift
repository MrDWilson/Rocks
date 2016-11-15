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
        private let title = SKLabelNode()
        
        private let customiseLabel   = SKLabelNode()
        private let customiseButton  = SKSpriteNode()
        
        private let leaderboardLabel  = SKLabelNode()
        private let leaderboardButton = SKSpriteNode()
        
        private let optionsLabel   = SKLabelNode()
        private let optionsButton  = SKSpriteNode()
        
        private let aboutLabel   = SKLabelNode()
        private let aboutButton    = SKSpriteNode()
        
        private let player: Player!
        
        private let screenWidth: Int!
        private let screenHeight: Int!
        
        init (w: Int, h: Int, p: Player) {
            player = p
            screenWidth = w
            screenHeight = h
            
            super.init()
            
            title.text = String("Rocks")
            title.fontSize = 100
            title.horizontalAlignmentMode = .center
            title.fontColor = UIColor.white
            title.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.82))
            addChild(title)
            
            customiseLabel.text = String("customise ship")
            customiseLabel.fontSize = 28
            customiseLabel.horizontalAlignmentMode = .center
            customiseLabel.fontColor = UIColor.lightGray
            customiseLabel.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.35))
            addChild(customiseLabel)
            
            customiseButton.name = String("customiseButton")
            customiseButton.size = CGSize(width: w * 2, height: 42)
            customiseButton.color = UIColor.clear
            customiseButton.position = CGPoint(x: 0, y: Int(Double(screenHeight) * 0.35))
            addChild(customiseButton)
            
            leaderboardLabel.text = String("leaderboard")
            leaderboardLabel.fontSize = 28
            leaderboardLabel.horizontalAlignmentMode = .center
            leaderboardLabel.fontColor = UIColor.lightGray
            leaderboardLabel.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.27))
            addChild(leaderboardLabel)
            
            leaderboardButton.name = String("leaderboardButton")
            leaderboardButton.size = CGSize(width: w * 2, height: 42)
            leaderboardButton.color = UIColor.clear
            leaderboardButton.position = CGPoint(x: 0, y: Int(Double(screenHeight) * 0.27))
            addChild(leaderboardButton)
            
            optionsLabel.text = String("options")
            optionsLabel.fontSize = 28
            optionsLabel.horizontalAlignmentMode = .center
            optionsLabel.fontColor = UIColor.lightGray
            optionsLabel.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.19))
            addChild(optionsLabel)
            
            optionsButton.name = String("optionsButton")
            optionsButton.size = CGSize(width: w * 2, height: 42)
            optionsButton.color = UIColor.clear
            optionsButton.position = CGPoint(x: 0, y: Int(Double(screenHeight) * 0.19))
            addChild(optionsButton)
            
            aboutLabel.text = String("about")
            aboutLabel.fontSize = 28
            aboutLabel.horizontalAlignmentMode = .center
            aboutLabel.fontColor = UIColor.lightGray
            aboutLabel.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.11))
            addChild(aboutLabel)
            
            aboutButton.name = String("aboutButton")
            aboutButton.size = CGSize(width: w * 2, height: 42)
            aboutButton.color = UIColor.clear
            aboutButton.position = CGPoint(x: 0, y: Int(Double(screenHeight) * 0.11))
            addChild(aboutButton)

        }
        
        // :(
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            player.move(to: CGPoint(x: screenWidth / 2, y: Int(Double(screenHeight) * 0.58)))
        }
    }
}
