/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  LeaderboardBackEnd.swift
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
    class LeaderboardBackEnd: UIViewController, GKGameCenterControllerDelegate {
        
        var leaderboardScores = [GKScore]()
        
        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
        }
        
        
        func updateScore(score : Int) {
            if(GKLocalPlayer.localPlayer().isAuthenticated) {
                
                let scoreReporter = GKScore(leaderboardIdentifier: "TestOne")
                
                scoreReporter.value = Int64(score)
                
                GKScore.report([scoreReporter], withCompletionHandler: ( { (error: Error?) -> Void in
                    if (error != nil) {
                        // handle error
                        print("Error: " + (error?.localizedDescription)!);
                    } else {
                        print("Score reported: \(scoreReporter.value)")
                    }
                }))
                
            }
        }
        
        func loads() {
            let leaderboard = GKLeaderboard()
            leaderboard.playerScope = .global
            leaderboard.timeScope = .allTime
            leaderboard.identifier = "TestOne"
            leaderboard.range = NSRange(location: 1, length: 10)
            
            leaderboard.loadScores { scores, error in
                guard let scores = scores else { return }
                self.leaderboardScores = scores
            }
        }
        
        func getEntries() -> [GKScore] {
            loads()
            print(leaderboardScores.count)
            return leaderboardScores
        }
    }
}
