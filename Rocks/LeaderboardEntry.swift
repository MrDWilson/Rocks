//
//  LeaderboardEntry.swift
//  Rocks
//
//  Created by Ryan Needham on 11/01/2017.
//  Copyright © 2017 Ryan Needham. All rights reserved.
//

import SpriteKit

extension GameScene {
    class LeaderboardEntry: SKNode {
        private let numberMachine = NumberFormatter()
        
        public var rankLabel     = SKLabelNode(fontNamed: "Arial")
        public var usernameLabel = SKLabelNode(fontNamed: "Arial")
        public var scoreLabel    = SKLabelNode()
        public var shipNode:     Ship!
        
        init (rank: Int, username: String, score: Int64, ship: Ship, w: CGFloat, h: CGFloat) {
            super.init()
            var baseline = h - ((CGFloat(rank) * 120))
            
            numberMachine.numberStyle = .decimal
            
            switch (rank) {
            case 1: rankLabel.fontColor = UIColor.white; break
            case 2: rankLabel.fontColor = UIColor.lightGray; break
            default: rankLabel.fontColor = UIColor.darkGray; break
            }
            
            
            if(rank == 1) {
                baseline = h - 80
                
                // POSITION
                rankLabel.text = String(describing: rank)
                rankLabel.horizontalAlignmentMode = .center
                rankLabel.position = CGPoint(x: w * 0.10, y: baseline - 22)
                rankLabel.fontSize = 80 //Needs change
                addChild(rankLabel)
                
                // SHIP
                shipNode = ship
                shipNode.position = CGPoint(x: w * 0.28, y:  baseline + 0)
                shipNode.xScale = 2
                shipNode.yScale = 2
                addChild(shipNode)
            } else {
                // POSITION
                rankLabel.text = String(describing: rank)
                rankLabel.horizontalAlignmentMode = .center
                rankLabel.position = CGPoint(x: w * 0.11, y: baseline - 16)
                rankLabel.fontSize = 48
                addChild(rankLabel)
                
                // SHIP
                shipNode = ship
                shipNode.position = CGPoint(x: w * 0.28, y:  baseline + 0)
                shipNode.xScale = 1.25
                shipNode.yScale = 1.25
                addChild(shipNode)
            }
            
            // USERNAME
            usernameLabel.text = username
            usernameLabel.horizontalAlignmentMode = .left
            usernameLabel.position = CGPoint(x: w * 0.42, y: baseline + 0)
            usernameLabel.fontSize = 26
            addChild(usernameLabel)
            
            // SCORE
            scoreLabel.text = numberMachine.string(from: NSNumber(value: score))
            scoreLabel.horizontalAlignmentMode = .left
            scoreLabel.position = CGPoint(x: w * 0.42, y: baseline - 32)
            scoreLabel.fontSize = 26
            addChild(scoreLabel)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setY (y: CGFloat) {
            rankLabel.position.y = y - 16
            usernameLabel.position.y = y
            scoreLabel.position.y = y - 32
            shipNode.position.y = y
        }
    }
}
