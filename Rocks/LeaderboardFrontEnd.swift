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
    
    class LeaderboardFrontEnd: SKNode {
        private var backend: LeaderboardBackEnd!
        private var removeList = [SKNode]()
        private var entries = [GKScore]()
        private var player:  GKScore!
        
        private var loadingLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light");
        
        init (w: Int, h: Int, p: Player) {
            backend = LeaderboardBackEnd()
            
            loadingLabel.text = LocalisedStringMachine.getString(string: "loading") + "..."
            loadingLabel.fontSize = 64
            loadingLabel.horizontalAlignmentMode = .center
            loadingLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 0.88)
            loadingLabel.position = CGPoint(x: w / 2, y: h / 2)
            
            super.init()
            addChild(loadingLabel)
            loadLeaderboard(w: w, h: h)
            
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func scrollUp () {
            removeList.forEach {
                $0.position.x -= 0.01
                $0.position.y -= 0.01
            }
        }
        
        func scrollDown () {
            removeList.forEach {
                $0.position.x += 0.01
                $0.position.y += 0.01
            }
        }
        
        func update () {}
        
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
            loadingLabel.run(SKAction.removeFromParent());
            
            if (!entries.isEmpty) {entries.removeAll()}
            entries = backend.getEntries()
            player = backend.getPlayer()
            
            removeList.forEach {$0.removeFromParent()}
            
            entries.forEach {
                let shipVec = Vector3D(context: $0.context)
                if ($0.rank <= 5) && ($0.rank > 0) {
                    removeList.append(LeaderboardEntry (
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
