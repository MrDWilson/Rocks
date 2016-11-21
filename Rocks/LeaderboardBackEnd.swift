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
        
        //Variable for storing the current leaderboard score
        private var leaderboardScores = [GKScore]()
        
        //Required implemented function
        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
        }
        
        //Updating the score
        func updateScore(score : Int) {
            
            //If the player is logged in
            if(GKLocalPlayer.localPlayer().isAuthenticated) {
                
                //Declare reported assigned with the required leaderboardID
                let scoreReporter = GKScore(leaderboardIdentifier: "highScore")
                
                //Set the value as the players score
                scoreReporter.value = Int64(score)
                
                //Set the context (ship/colour, laser colour and thruster)
                //scoreReporter.context(testVector.getAsOne())
                
                //Report the score to the leaderboard
                GKScore.report([scoreReporter], withCompletionHandler: ( { (error: Error?) -> Void in
                    //If there is an error
                    if (error != nil) {
                        // handle error
                        print("Error: " + (error?.localizedDescription)!);
                    } else {
                        //Score is reported, print is for testing
                        print("Score reported: \(scoreReporter.value)")
                    }
                }))
                
            }
        }
        
        //Function to load leaderboard
        private func retreiveFromServer() {
            let leaderboard = GKLeaderboard() //Initialise leaderboard
            leaderboard.playerScope = .global //Set players to global (instead of friends)
            leaderboard.timeScope = .allTime //Set time limit of all time
            leaderboard.identifier = "highScore" //Set leaderboard ID
            //leaderboard.range = NSRange(location: 1, length: 10) //Maximum limit of users
            
            //Load the socore
            leaderboard.loadScores {
                (scores, error) -> Void in
                //If there is an error
                if error != nil {
                    //Handle error
                    print("Score loading error: \(error)")
                } else {
                    //Set own leaderboard list to the online one
                    self.leaderboardScores = scores!
                    //For testing purposes
                    if(self.leaderboardScores == scores!) {print("Scores loaded successfully")}
                    //Also for testing purposes
                    print("\(scores?.count)")
                }
            }
        }
        
        //Returns the leaderboard score
        func getEntries() -> [GKScore] {
            //Returns the current score
            return leaderboardScores
        }
        
        //This is used to load the leaderboard, and tell front end when it is finished
        func loadLeaderboard(completion: ((Bool) -> ())?) {
            retreiveFromServer()
            completion?(true)
        }
    }
}
