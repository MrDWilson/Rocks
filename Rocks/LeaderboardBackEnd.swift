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
        
        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
        }
        
        
        func updateScore(score : Int) {
            
            if(GKLocalPlayer.localPlayer().isAuthenticated) {
                
                let scoreReporter = GKScore(leaderboardIdentifier: "high_score_leaderboard")
                
                scoreReporter.value = Int64(score)
                
                let scoreArray : [GKScore] = [scoreReporter]
                
                GKScore.report(scoreArray, withCompletionHandler: nil)
                
            }
        }
        
        func loads() -> GKLeaderboard {
            let leaderboard = GKLeaderboard()
            leaderboard.playerScope = .global
            leaderboard.timeScope = .allTime
            leaderboard.identifier = "high_score_leaderboard"
//            leaderboard.range = NSRange(location: 1, length: 10)
            
            leaderboard.loadScores { scores, error in
                guard let scores = scores else { return }
                print(scores.count)
                for score in scores {
                    print("User \(score.player?.alias ?? String()) has a high score of: \(score.value)")
                }
            }
            
            return leaderboard
        }
    }
}
