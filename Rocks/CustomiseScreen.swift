/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  CustomiseScreen.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class CustomiseScreen: SKNode {
        private var backLabel  = SKLabelNode()
        private var backButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 200, height: 100))
        
        private var nextShipColour = SKSpriteNode()
        private let prevShipColour = SKSpriteNode()
        
        private var nextThrusterColour = SKSpriteNode()
        private var prevThrusterColour = SKSpriteNode()
        
        private let nextImage = SKTexture(imageNamed: "next")
        private let prevImage = SKTexture(imageNamed: "previous")
        
        init (w: Int, h: Int, p: Player) {
            super.init()
            
            // back
            backLabel.text = String("back")
            backLabel.horizontalAlignmentMode = .left
            backLabel.position = CGPoint(x: 10, y: h - 50)
            //addChild(backLabel)
            
            
            backButton.name = String("back")
            backButton.position = CGPoint(x: 10, y: h - 10)
            //addChild(backButton)
            
            // change ship color
            nextShipColour.texture = nextImage
            nextShipColour.size.width = 64
            nextShipColour.size.height = 64
            nextShipColour.position = CGPoint(x: w - 100, y: Int(Double(h) * 0.58))
            addChild(nextShipColour)
            
            prevShipColour.texture = prevImage
            prevShipColour.size.width = 64
            prevShipColour.size.height = 64
            prevShipColour.position = CGPoint(x: 100, y: Int(Double(h) * 0.58))
            addChild(prevShipColour)
            
            nextThrusterColour.texture = nextImage
            nextThrusterColour.size.width = 64
            nextThrusterColour.size.height = 64
            nextThrusterColour.position = CGPoint(x: w - 148, y: Int(Double(h) * 0.40))
            addChild(nextThrusterColour)
            
            prevThrusterColour.texture = prevImage
            prevThrusterColour.size.width = 64
            prevThrusterColour.size.height = 64
            prevThrusterColour.position = CGPoint(x: 138, y: Int(Double(h) * 0.40))
            addChild(prevThrusterColour)
            
            // change thruster
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            
        }
    }
}
