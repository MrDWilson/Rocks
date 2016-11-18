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
    class LeaderboardEntry {
        public var positionLabel = SKLabelNode(fontNamed: "Arial")
        public var usernameLabel = SKLabelNode(fontNamed: "Arial")
        public var scoreLabel    = SKLabelNode(fontNamed: "Arial")
        public var shipNode:     Ship!
        
        init (position: UInt32, username: String, score: Int, ship: Ship, h: CGFloat, w: CGFloat) {
            
            // POSITION
            positionLabel.text = String(describing: position)
            positionLabel.horizontalAlignmentMode = .center
            positionLabel.position = CGPoint(x: w * 0.08, y: h * 0.90)
            positionLabel.fontSize = 26
            
            // SHIP
            shipNode = ship
            shipNode.position = CGPoint(x: w * 0.25, y: h * 0.90)
            shipNode.xScale = 1.5
            shipNode.yScale = 1.5
            
            // USERNAME
            usernameLabel.text = username
            usernameLabel.horizontalAlignmentMode = .left
            usernameLabel.position = CGPoint(x: w * 0.38, y: h * 0.90)
            usernameLabel.fontSize = 26
            
            // SCORE
            scoreLabel.text = String(describing: score)
            scoreLabel.horizontalAlignmentMode = .left
            scoreLabel.position = CGPoint(x: w * 0.38, y: h * 0.86)
            scoreLabel.fontSize = 26
        }
    }
    
    class LeaderboardFrontEnd: SKNode {
        private var backend: LeaderboardBackEnd!
        
        
         private var backLabel  = SKLabelNode()
         private var backButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 200, height: 100))
         
         private var number1Pos = SKLabelNode(fontNamed: "Arial")
         private var number1Name = SKLabelNode(fontNamed: "Arial")
         private var number1Score = SKLabelNode()
         
         private var dummy1 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.white)
         private var dummy1Pos = SKLabelNode(fontNamed: "Arial")
         private var dummy1Name = SKLabelNode(fontNamed: "Arial")
         private var dummy1Score = SKLabelNode()
         
         private var dummy2 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.black)
         private var dummy2Pos = SKLabelNode(fontNamed: "Arial")
         private var dummy2Name = SKLabelNode(fontNamed: "Arial")
         private var dummy2Score = SKLabelNode()
         
         private var dummy3 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.magenta)
         private var dummy3Pos = SKLabelNode(fontNamed: "Arial")
         private var dummy3Name = SKLabelNode(fontNamed: "Arial")
         private var dummy3Score = SKLabelNode()
         
         private var dummy4 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.darkGray)
         private var dummy4Pos = SKLabelNode(fontNamed: "Arial")
         private var dummy4Name = SKLabelNode(fontNamed: "Arial")
         private var dummy4Score = SKLabelNode()
         
         private var dummy5 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.orange)
         private var dummy5Pos = SKLabelNode(fontNamed: "Arial")
         private var dummy5Name = SKLabelNode(fontNamed: "Arial")
         private var dummy5Score = SKLabelNode()
         
         private var dummy6 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.white)
         private var dummy6Pos = SKLabelNode(fontNamed: "Arial")
         private var dummy6Name = SKLabelNode(fontNamed: "Arial")
         private var dummy6Score = SKLabelNode()
         
         private var dummy7 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.red)
         private var dummy7Pos = SKLabelNode(fontNamed: "Arial")
         private var dummy7Name = SKLabelNode(fontNamed: "Arial")
         private var dummy7Score = SKLabelNode()
         
         private var dummy8 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.green)
         private var dummy8Pos = SKLabelNode(fontNamed: "Arial")
         private var dummy8Name = SKLabelNode(fontNamed: "Arial")
         private var dummy8Score = SKLabelNode()
         
         private var entries = [GKScore]()
         
         
        
        init (w: Int, h: Int, p: Player) {
            backend = LeaderboardBackEnd()
            
            super.init()
            
            // back button
            backLabel.text = String("back")
            backLabel.horizontalAlignmentMode = .left
            backLabel.position = CGPoint(x: 10, y: h - 50)
            //addChild(backLabel)
            
            backButton.name = String("back")
            backButton.position = CGPoint(x: 10, y: h - 10)
            //addChild(backButton)
            
            /**
             *  NOTE - MAKE DYNAMIC SO PLAYER NAMES FIT
             */
            
            number1Pos.text = String("1")
            number1Pos.horizontalAlignmentMode = .center
            number1Pos.position = CGPoint(x: CGFloat(w) * 0.08, y: CGFloat(h) * 0.90)
            number1Pos.fontSize = 26
            
            number1Name.text = String("buddy")
            number1Name.horizontalAlignmentMode = .left
            number1Name.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.90)
            number1Name.fontSize = 26
            
            number1Score.text = String("1,000,000")
            number1Score.horizontalAlignmentMode = .left
            number1Score.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.86)
            number1Score.fontSize = 26
            
            dummy1.position = CGPoint(x: CGFloat(w) * 0.25, y: CGFloat(h) * 0.70)
            dummy1.xScale = 1.5
            dummy1.yScale = 1.5
            
            dummy1Pos.text = String("2")
            dummy1Pos.horizontalAlignmentMode = .center
            dummy1Pos.position = CGPoint(x: CGFloat(w) * 0.08, y: CGFloat(h) * 0.70)
            dummy1Pos.fontSize = 26
            
            dummy1Name.text = String("guy")
            dummy1Name.horizontalAlignmentMode = .left
            dummy1Name.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.70)
            dummy1Name.fontSize = 26
            
            dummy1Score.text = String("900,000")
            dummy1Score.horizontalAlignmentMode = .left
            dummy1Score.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.66)
            dummy1Score.fontSize = 26
            
            dummy2.position = CGPoint(x: CGFloat(w) * 0.25, y: CGFloat(h) * 0.50)
            dummy2.xScale = 1.5
            dummy2.yScale = 1.5
            
            dummy2Pos.text = String("3")
            dummy2Pos.horizontalAlignmentMode = .center
            dummy2Pos.position = CGPoint(x: CGFloat(w) * 0.08, y: CGFloat(h) * 0.50)
            dummy2Pos.fontSize = 26
            
            dummy2Name.text = String("friend")
            dummy2Name.horizontalAlignmentMode = .left
            dummy2Name.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.50)
            dummy2Name.fontSize = 26
            
            dummy2Score.text = String("800,000")
            dummy2Score.horizontalAlignmentMode = .left
            dummy2Score.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.46)
            dummy2Score.fontSize = 26
            
            
            dummy3.position = CGPoint(x: CGFloat(w) * 0.25, y: CGFloat(h) * 0.30)
            dummy3.xScale = 1.5
            dummy3.yScale = 1.5
            
            dummy3Pos.text = String("4")
            dummy3Pos.horizontalAlignmentMode = .center
            dummy3Pos.position = CGPoint(x: CGFloat(w) * 0.08, y: CGFloat(h) * 0.30)
            dummy3Pos.fontSize = 26
            
            dummy3Name.text = String("Daveeed")
            dummy3Name.horizontalAlignmentMode = .left
            dummy3Name.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.30)
            dummy3Name.fontSize = 26
            
            dummy3Score.text = String("700,000")
            dummy3Score.horizontalAlignmentMode = .left
            dummy3Score.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.26)
            dummy3Score.fontSize = 26
            
            dummy4.position = CGPoint(x: CGFloat(w) * 0.25, y: CGFloat(h) * 0.10)
            dummy4.xScale = 1.5
            dummy4.yScale = 1.5
            
            dummy4Pos.text = String("5")
            dummy4Pos.horizontalAlignmentMode = .center
            dummy4Pos.position = CGPoint(x: CGFloat(w) * 0.08, y: CGFloat(h) * 0.10)
            dummy4Pos.fontSize = 26
            
            dummy4Name.text = String("Aman")
            dummy4Name.horizontalAlignmentMode = .left
            dummy4Name.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.10)
            dummy4Name.fontSize = 26
            
            dummy4Score.text = String("600,000")
            dummy4Score.horizontalAlignmentMode = .left
            dummy4Score.position = CGPoint(x: CGFloat(w) * 0.38, y: CGFloat(h) * 0.06)
            dummy4Score.fontSize = 26
            
            dummy5.position = CGPoint(x: CGFloat(w) * 0.25, y: CGFloat(h) * -0.10)
            dummy5.xScale = 1.5
            dummy5.yScale = 1.5
            dummy5Pos.text = String("6")
            dummy5Pos.horizontalAlignmentMode = .center
            dummy5Pos.position = CGPoint(x: CGFloat(w) * 0.08, y: CGFloat(h) * -0.10)
            dummy5Pos.fontSize = 16
            
            dummy6.position = CGPoint(x: CGFloat(w) * 0.25, y: CGFloat(h) * -0.30)
            dummy6.xScale = 1.5
            dummy6.yScale = 1.5
            dummy6Pos.text = String("7")
            dummy6Pos.horizontalAlignmentMode = .center
            dummy6Pos.position = CGPoint(x: CGFloat(w) * 0.08, y: CGFloat(h) * -0.30)
            dummy6Pos.fontSize = 16
            
            dummy7.position = CGPoint(x: CGFloat(w) * 0.25, y: CGFloat(h) * -0.50)
            dummy7.xScale = 1.5
            dummy7.yScale = 1.5
            dummy7Pos.text = String("8")
            dummy7Pos.horizontalAlignmentMode = .center
            dummy7Pos.position = CGPoint(x: CGFloat(w) * 0.08, y: CGFloat(h) * -0.50)
            dummy7Pos.fontSize = 16
            
            dummy8.position = CGPoint(x: CGFloat(w) * 0.25, y: CGFloat(h) * -0.70)
            dummy8.xScale = 1.5
            dummy8.yScale = 1.5
            dummy8Pos.text = String("9")
            dummy8Pos.horizontalAlignmentMode = .center
            dummy8Pos.position = CGPoint(x: CGFloat(w) * 0.08, y: CGFloat(h) * -0.70)
            dummy8Pos.fontSize = 16
            
            addChild(number1Pos)
            addChild(number1Name)
            addChild(number1Score)
            
            addChild(dummy1)
            addChild(dummy1Pos)
            addChild(dummy1Name)
            addChild(dummy1Score)
            
            addChild(dummy2)
            addChild(dummy2Pos)
            addChild(dummy2Name)
            addChild(dummy2Score)
            
            addChild(dummy3)
            addChild(dummy3Pos)
            addChild(dummy3Name)
            addChild(dummy3Score)
            
            addChild(dummy4)
            addChild(dummy4Pos)
            addChild(dummy4Name)
            addChild(dummy4Score)
            
            addChild(dummy5)
            addChild(dummy5Pos)
            addChild(dummy5Name)
            addChild(dummy5Score)
            
            addChild(dummy6)
            addChild(dummy6Pos)
            addChild(dummy6Name)
            
            addChild(dummy7)
            addChild(dummy7Pos)
            addChild(dummy7Name)
            
            addChild(dummy8)
            addChild(dummy8Pos)
            addChild(dummy8Name)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func scrollUp () {
            print("hello")
            
            /*
             
             dummy1.position.y += 0.001
             dummy2.position.y += 0.001
             dummy3.position.y += 0.001
             dummy4.position.y += 0.001
             dummy5.position.y += 0.001
             dummy6.position.y += 0.001
             dummy7.position.y += 0.001
             dummy8.position.y += 0.001
             */
        }
        
        func scrollDown () {
            print("hello")
            
            /*
             dummy1.position.y -= 0.001
             dummy2.position.y -= 0.001
             dummy3.position.y -= 0.001
             dummy4.position.y -= 0.001
             dummy5.position.y -= 0.001
             dummy6.position.y -= 0.001
             dummy7.position.y -= 0.001
             dummy8.position.y -= 0.001
             
             */
        }
        
        func update () {
            
        }
    }
}
