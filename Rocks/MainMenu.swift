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
        
        private let customise   = SKLabelNode()
        private let leaderboard = SKLabelNode()
        private let options     = SKLabelNode()
        private let about       = SKLabelNode()
        
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
            
            customise.text = String("customise ship")
            customise.fontSize = 28
            customise.horizontalAlignmentMode = .center
            customise.fontColor = UIColor.lightGray
            customise.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.35))
            addChild(customise)
            
            leaderboard.text = String("leaderboard")
            leaderboard.fontSize = 28
            leaderboard.horizontalAlignmentMode = .center
            leaderboard.fontColor = UIColor.lightGray
            leaderboard.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.27))
            addChild(leaderboard)
            
            options.text = String("options")
            options.fontSize = 28
            options.horizontalAlignmentMode = .center
            options.fontColor = UIColor.lightGray
            options.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.19))
            
            addChild(options)
            
            about.text = String("about")
            about.fontSize = 28
            about.horizontalAlignmentMode = .center
            about.fontColor = UIColor.lightGray
            about.position = CGPoint(x: w / 2, y: Int(Double(screenHeight) * 0.11))
            addChild(about)

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
