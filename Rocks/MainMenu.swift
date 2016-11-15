/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  MainMenu.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class MainMenu: SKNode {
        private let title = SKLabelNode()
        
        private let nextSpriteLabel = SKLabelNode()
        private let prevSpriteLabel = SKLabelNode()
        
        private let nextThrusterLabel = SKLabelNode()
        private let prevThrusterLabel = SKLabelNode()
        
        private let player: Player!
        
        init (w: Int, h: Int, p: Player) {
            player = p
            
            super.init()
            
            title.text = String("Rocks")
            title.fontSize = 100
            title.horizontalAlignmentMode = .center
            title.fontColor = UIColor.white
            title.position = CGPoint(x: w / 2, y: h - 200)
            addChild(title)
            
            nextSpriteLabel.text = String(">")
            nextSpriteLabel.fontSize = 24
            nextSpriteLabel.horizontalAlignmentMode = .right
            nextSpriteLabel.fontColor = UIColor.white

            //addChild(nextSpriteLabel)
            
            prevSpriteLabel.text = String("<")
            prevSpriteLabel.fontSize = 24
            prevSpriteLabel.horizontalAlignmentMode = .left
            prevSpriteLabel.fontColor = UIColor.white

            //addChild(prevSpriteLabel)
            
            nextThrusterLabel.text = String(">")
            nextThrusterLabel.fontSize = 24
            nextThrusterLabel.horizontalAlignmentMode = .right
            nextThrusterLabel.fontColor = UIColor.white

            //addChild(nextThrusterLabel)
            
            prevThrusterLabel.text = String("<")
            prevThrusterLabel.fontSize = 24
            prevThrusterLabel.horizontalAlignmentMode = .left
            prevThrusterLabel.fontColor = UIColor.white

            //addChild(prevThrusterLabel)
        }
        
        // :(
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            nextSpriteLabel.position = CGPoint(x: player.getPosition().x + 60, y: player.getPosition().y)
            prevSpriteLabel.position = CGPoint(x: player.getPosition().x - 60, y: player.getPosition().y )
            nextThrusterLabel.position = CGPoint(x: player.getPosition().x + 60, y: player.getPosition().y - 40)
            prevThrusterLabel.position = CGPoint(x: player.getPosition().x - 60, y: player.getPosition().y - 40)
        }
    }
}
