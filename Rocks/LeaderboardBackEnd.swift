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
        
        //Variable for current player
        private var playerScore = GKScore()
        
        //Required implemented function
        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
        }
        
        //Updating the score
        func updateScore(score : Int, shipVector: Vector3D) {
            
            //If the player is logged in
            if(GKLocalPlayer.localPlayer().isAuthenticated) {
                
                //Declare reported assigned with the required leaderboardID
                let scoreReporter = GKScore(leaderboardIdentifier: "TestOne")
                
                //Set the value as the players score
                scoreReporter.value = Int64(score)
                
                //Set the context (ship/colour, laser colour and thruster)
                scoreReporter.context = UInt64(shipVector.getAsOne())
                
                print(shipVector.getAsOne())
                
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
        private func retreiveFromServer(completion: ((Bool) -> ())?) {
            
            let leaderboard = GKLeaderboard() //Initialise leaderboard
            leaderboard.playerScope = .global //Set players to global (instead of friends)
            leaderboard.timeScope = .allTime //Set time limit of all time
            leaderboard.identifier = "TestOne" //Set leaderboard ID
            //leaderboard.range = NSRange(location: 1, length: 10) //Maximum limit of users
            let firstTime = Save.getFirstTime()
            if firstTime {
                updateScore(score: 0, shipVector: Vector3D(x: 01, y: 01, z: 01))
                Save.setFirstTime()
            }
            
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
                    completion?(true)
                }
            }
        }
        
        //Function to load leaderboard
        private func loadCurrentPlayer(completion: ((Bool) -> ())?) {
            let leaderboard = GKLeaderboard() //Initialise leaderboard
            leaderboard.playerScope = .global //Set players to global (instead of friends)
            leaderboard.timeScope = .allTime //Set time limit of all time
            leaderboard.identifier = "TestOne" //Set leaderboard ID
            //leaderboard.range = NSRange(location: 1, length: 10) //Maximum limit of users
            let firstTime = true
            if firstTime {
                updateScore(score: 0, shipVector: Vector3D(x: 01, y: 01, z: 01))
                Save.setFirstTime()
            }
            
            //Load the socore
            leaderboard.loadScores {
                (scores, error) -> Void in
                //If there is an error
                if error != nil {
                    //Handle error
                    print("Score loading error: \(error)")
                } else {
                    //Set own leaderboard list to the online one
                    self.playerScore = leaderboard.localPlayerScore!
                    //For testing purposes
                    if(self.leaderboardScores == scores!) {print("Scores loaded successfully")}
                    //Also for testing purposes
                    print("\(scores?.count)")
                    completion?(true)
                }
            }
        }
        
        
        func getPlayer() -> GKScore {
            //Return the current score
            return playerScore
        }
        
        //Returns the leaderboard score
        func getEntries() -> [GKScore] {
            //Returns the current score
            return leaderboardScores
        }
        
        //This is used to load the leaderboard, and tell front end when it is finished
        func loadLeaderboard(completion: ((Bool) -> ())?) {
            //Loading the leaderboard
            retreiveFromServer(completion: { success in
                if success {
                    //Tell front end we are done
                    completion?(true)
                } else { print("Fuck you") }
                
            })
        }
        
        func loadPlayer(completion: ((Bool) -> ())?) {
            //Loading player
            loadCurrentPlayer(completion: { success in
                if success {
                    //Tell front end we are done
                    completion?(true)
                } else { print("Fuck you") }
            })
        }
    }
}
