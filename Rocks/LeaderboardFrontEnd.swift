/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  LeaderboardFrontEnd.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class LeaderboardEntry {
        public var shipID:Int!
        public var color: UIColor!
        public var thrusterID: Int!
        public var name: String!
        public var score: Int!
    }

    class LeaderboardFrontEnd: SKNode {
        private var backend: LeaderboardBackEnd!
        
        private var backLabel  = SKLabelNode()
        private var backButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 200, height: 100))
        
        private var entries = [LeaderboardEntry]()
        
        init (w: Int, h: Int, p: Player) {
            backend = LeaderboardBackEnd()
            
            super.init()
            
            // back button
            backLabel.text = String("back")
            backLabel.horizontalAlignmentMode = .left
            backLabel.position = CGPoint(x: 10, y: h - 50)
            addChild(backLabel)
            
            backButton.name = String("back")
            backButton.position = CGPoint(x: 10, y: h - 10)
            addChild(backButton)
            
            // entries
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            
        }
    }
}
