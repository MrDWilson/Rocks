/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  GameViewController.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {
    
    var score: Int = 0 // Stores the score
    
    var leaderboard = GKLeaderboard()
    
    
    var gcEnabled = Bool() // Stores if the user has Game Center enabled
    var gcDefaultLeaderBoard = String() // Stores the default leaderboardID

    override func viewDidLoad() {
        
        self.authenticateLocalPlayer()
        
        super.viewDidLoad()
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            //view.isAsynchronous = true
            
            view.showsFPS = true
           // view.showsNodeCount = true
           // view.showsDrawCount = true
           // view.showsPhysics = true
        
           //updateScore(score: 64)
            loadScore()
            
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1 Show login if player is not logged in
                self.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
                // 2 Player is already euthenticated & logged in, load game center
                self.gcEnabled = true
                
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer: String?, error: Error?) -> Void in
                    if error != nil {
                        print(error as Any)
                    } else {
                        self.gcDefaultLeaderBoard = leaderboardIdentifer!
                    }
                })
                
                
            } else {
                // 3 Game center is not enabled on the users device
                self.gcEnabled = false
                print("Local player could not be authenticated, disabling game center")
                print(error as Any)
            }
            
        }
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    func go() {
        let leaderboardID = "LeaderboardID"
        let sScore = GKScore(leaderboardIdentifier: leaderboardID)
        sScore.value = Int64(100)
        print(100)
    
        GKScore.report([sScore], withCompletionHandler: { (error: Error?) -> Void in
        if error != nil {
            print(error!.localizedDescription)
        } else {
            print("Score submitted")
    
            }
        })
    }
    /*
    
    
    
    func doSomething() {
        print(leaderboard.localPlayerScore?.player?.alias as Any)
    }_*/
    
    func updateScore(score : Int) {
        
        if(GKLocalPlayer.localPlayer().isAuthenticated) {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "high_score_leaderboard")
            
            scoreReporter.value = Int64(score)
            
            let scoreArray : [GKScore] = [scoreReporter]
            
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
        
    }
    
    func loadScore(){
        
        let leaderBoardRequest = GKLeaderboard()
        
        leaderBoardRequest.identifier = "high_score_leaderboard"
        leaderBoardRequest.playerScope = GKLeaderboardPlayerScope.global
        leaderBoardRequest.timeScope = GKLeaderboardTimeScope.allTime;
        
        leaderBoardRequest.loadScores { (scores, error) -> Void in
            if (error != nil) {
                print("Error: \(error!.localizedDescription)")
            } else if (scores != nil) {
                let localPlayerScore = leaderBoardRequest.localPlayerScore
                print("Local player's score: \(localPlayerScore?.value)")
                print("High score: \(leaderBoardRequest.scores?.first)")
                print("All scores: \(scores)")
            }
            
        }
        
    }
    
}

