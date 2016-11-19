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
import GameKit

extension GameScene {
    class LeaderboardEntry: SKNode {
        private let numberMachine = NumberFormatter()
    
        public var rankLabel     = SKLabelNode(fontNamed: "Arial")
        public var usernameLabel = SKLabelNode(fontNamed: "Arial")
        public var scoreLabel    = SKLabelNode()
        public var shipNode:     Ship!
        
        init (rank: Int, username: String, score: Int64, ship: Ship, w: CGFloat, h: CGFloat) {
            super.init()
            let baseline = h - ((CGFloat(rank) * 126))
            
            numberMachine.numberStyle = .decimal
            
            // POSITION
            rankLabel.text = String(describing: rank)
            rankLabel.horizontalAlignmentMode = .center
            rankLabel.position = CGPoint(x: w * 0.11, y: baseline - 16)
            rankLabel.fontSize = 48
            rankLabel.fontColor = UIColor.gray
            addChild(rankLabel)
            
            // SHIP
            shipNode = ship
            shipNode.position = CGPoint(x: w * 0.28, y:  baseline + 0)
            shipNode.xScale = 1.25
            shipNode.yScale = 1.25
            addChild(shipNode)
            
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
    }
    
    class LeaderboardFrontEnd: SKNode {
        private var backend: LeaderboardBackEnd!
        private var entries: [GKScore]!
        
        init (w: Int, h: Int, p: Player) {
            backend = LeaderboardBackEnd()
            
            super.init()
            
            // Real Entries1
            entries = backend.getEntries()
            entries.forEach {
                addChild (
                    LeaderboardEntry (
                        rank:     $0.rank,
                        username: $0.player!.displayName!,
                        score:    $0.value,
                        ship:     Ship(bID: 1, tID: (1 + Int(arc4random_uniform(7))), cID: Int(arc4random_uniform(UInt32(Ship.ShipColour.COLOUR_BOUNDRY.rawValue)))), // THIS NEEDS USER SHIP COMPATABILITY
                        w:        CGFloat(w),
                        h:        CGFloat(h)
                    )
                )
                
                print("Entry Added")
            }
            
            // Dummy Entries (COMMENT OUT WHEN LIVE)
            addChild(LeaderboardEntry(
                rank: 1,
                username: String("myman"),
                score: 1000000,
                ship: Ship(bID: (Int(arc4random_uniform(3))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(Ship.ShipColour.COLOUR_BOUNDRY.rawValue)))),
                w: CGFloat(w),
                h: CGFloat(h)
            ))
            
            addChild(LeaderboardEntry(
                rank: 2,
                username: String("yourman"),
                score: 900000,
                ship: Ship(bID: (Int(arc4random_uniform(3))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(Ship.ShipColour.COLOUR_BOUNDRY.rawValue)))),
                w: CGFloat(w),
                h: CGFloat(h)
            ))
            
            addChild(LeaderboardEntry(
                rank: 3,
                username: String("hisman"),
                score: 800000,
                ship: Ship(bID: (Int(arc4random_uniform(3))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(Ship.ShipColour.COLOUR_BOUNDRY.rawValue)))),
                w: CGFloat(w),
                h: CGFloat(h)
            ))
            
            addChild(LeaderboardEntry(
                rank: 4,
                username: String("herman"),
                score: 700000,
                ship: Ship(bID: (Int(arc4random_uniform(3))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(Ship.ShipColour.COLOUR_BOUNDRY.rawValue)))),
                w: CGFloat(w),
                h: CGFloat(h)
            ))
            
            addChild(LeaderboardEntry(
                rank: 5,
                username: String("someman"),
                score: 600000,
                ship: Ship(bID: (Int(arc4random_uniform(3))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(Ship.ShipColour.COLOUR_BOUNDRY.rawValue)))),
                w: CGFloat(w),
                h: CGFloat(h)
            ))
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func scrollUp () {

        }
        
        func scrollDown () {

        }
        
        func update () {
            
        }
    }
}
