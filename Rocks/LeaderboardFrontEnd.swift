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
        
        private var backLabel  = SKLabelNode()
        private var backButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 200, height: 100))
        
        private var dummy1 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.white)
        private var dummy2 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.black)
        private var dummy3 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.magenta)
        private var dummy4 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.darkGray)
        
        private var dummy5 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.orange)
        private var dummy6 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.white)
        private var dummy7 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.red)
        private var dummy8 = Ship(bID: 1, tID: Int(1 + arc4random_uniform(7)), cID: UIColor.green)
        
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
            
            dummy1.position = CGPoint(x: CGFloat(w) * 0.2, y: CGFloat(h) * 0.35)
            dummy2.position = CGPoint(x: CGFloat(w) * 0.4, y: CGFloat(h) * 0.35)
            dummy3.position = CGPoint(x: CGFloat(w) * 0.6, y: CGFloat(h) * 0.35)
            dummy4.position = CGPoint(x: CGFloat(w) * 0.8, y: CGFloat(h) * 0.35)
            dummy5.position = CGPoint(x: CGFloat(w) * 0.2, y: CGFloat(h) * 0.15)
            dummy6.position = CGPoint(x: CGFloat(w) * 0.4, y: CGFloat(h) * 0.15)
            dummy7.position = CGPoint(x: CGFloat(w) * 0.6, y: CGFloat(h) * 0.15)
            dummy8.position = CGPoint(x: CGFloat(w) * 0.8, y: CGFloat(h) * 0.15)
            
            addChild(dummy1)
            addChild(dummy2)
            addChild(dummy3)
            addChild(dummy4)
            addChild(dummy5)
            addChild(dummy6)
            addChild(dummy7)
            addChild(dummy8)
            
            // entries
            let test = GKScore()
            test.value = 333333333333
            
            
            
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            
        }
    }
}
