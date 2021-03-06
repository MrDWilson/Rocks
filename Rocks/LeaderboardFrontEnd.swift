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
    
    class LeaderboardFrontEnd: SKNode {
        private var backend: LeaderboardBackEnd!
        private var removeList = [SKNode]()
        private var entries = [GKScore]()
        private var player:  GKScore!
        
        init (w: Int, h: Int, p: Player) {
            backend = LeaderboardBackEnd()
            
            super.init()
            loadLeaderboard(w: w, h: h)
            
            
            // Dummy Entries (COMMENT OUT WHEN LIVE)
//            addChild(LeaderboardEntry(
//                rank: 5,
//                username: String("myman"),
//                score: 1000000,
//                ship: Ship(bID: 10 + (Int(arc4random_uniform(2))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(REColour.COLOUR_BOUNDRY.rawValue)))),
//                w: CGFloat(w),
//                h: CGFloat(h)
//            ))
//
//            addChild(LeaderboardEntry(
//                rank: 2,
//                username: String("yourman"),
//                score: 900000,
//                ship: Ship(bID: (Int(arc4random_uniform(3))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(REColour.COLOUR_BOUNDRY.rawValue)))),
//                w: CGFloat(w),
//                h: CGFloat(h)
//            ))
//            
//            addChild(LeaderboardEntry(
//                rank: 3,
//                username: String("hisman"),
//                score: 800000,
//                ship: Ship(bID: (Int(arc4random_uniform(3))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(REColour.COLOUR_BOUNDRY.rawValue)))),
//                w: CGFloat(w),
//                h: CGFloat(h)
//            ))
//            
//            addChild(LeaderboardEntry(
//                rank: 4,
//                username: String("herman"),
//                score: 700000,
//                ship: Ship(bID: (Int(arc4random_uniform(3))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(REColour.COLOUR_BOUNDRY.rawValue)))),
//                w: CGFloat(w),
//                h: CGFloat(h)
//            ))
//            
//            addChild(LeaderboardEntry(
//                rank: 5,
//                username: String("someman"),
//                score: 600000,
//                ship: Ship(bID: (Int(arc4random_uniform(3))), tID: (1 + Int(arc4random_uniform(6))), cID: Int(arc4random_uniform(UInt32(REColour.COLOUR_BOUNDRY.rawValue)))),
//                w: CGFloat(w),
//                h: CGFloat(h)
//            ))
            
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
        
        func loadLeaderboard (w: Int, h: Int) {
            // Real Entries (only loads when the leaderboard is loaded from server
            // Also:: do this snipped of code every time the leaderboard needs to be
            // reloaded. E.g. when the leaderboard button is pressed (maybe only when
            // the leaderboard button is pressed?)
            backend.loadLeaderboard(completion: { success in
                if success {
                    //This is where the UI generation method will be called
                    //In said function, get entries will have to be called again
                    //as I have restructured how back end works
                    self.generateUI(w: w, h: h)
                } else {
                    print("Failed to lead leaderboards front end")
                }
            })
        }
        
        func generateUI(w: Int, h: Int) {
            
            if (!entries.isEmpty) {entries.removeAll()}
            entries = backend.getEntries()
            player = backend.getPlayer()
            
            removeList.forEach {$0.removeFromParent()}
            
            entries.forEach {
                let shipVec = Vector3D(context: $0.context)
                if ($0.rank <= 5) && ($0.rank > 0) {
                    removeList.append(                        LeaderboardEntry (
                        rank:     $0.rank,
                        username: $0.player!.alias!,
                        score:    $0.value,
                        ship:     Ship(bID: shipVec.getX(), tID: shipVec.getY(), cID: shipVec.getZ()), // THIS NEEDS USER SHIP COMPATABILITY
                        w:        CGFloat(w),
                        h:        CGFloat(h)
                    ))
                    
                    addChild (removeList.last!)
                }
//                } else if ($0.rank == 1) {
//                    //Code for adding a different size
//                }
            }
            
            /*let shipVec = Vector3D(context: player.context)
            let currentPlayer = LeaderboardEntry(
                rank:     player.rank,
                username: String("You"),
                score:    player.value,
                ship:     Ship(bID: shipVec.getX(), tID: shipVec.getY(), cID: shipVec.getZ()), // THIS NEEDS USER SHIP COMPATABILITY
                w:        CGFloat(w),
                h:        CGFloat(h)
            )
            currentPlayer.setY(y: 64)
            addChild (currentPlayer)*/
        }
    }
}
