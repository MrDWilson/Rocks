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
        
        private var nextShipTexture = SKSpriteNode()
        private let nextShipButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        private let prevShipTexture = SKSpriteNode()
        private let prevShipButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        private var nextThrusterTexture = SKSpriteNode()
        private let nextThrusterButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        private var prevThrusterTexture = SKSpriteNode()
        private let prevThrusterButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        private let nextImage = SKTexture(imageNamed: "next")
        private let prevImage = SKTexture(imageNamed: "previous")
        
        init (w: Int, h: Int, p: Player) {
            super.init()
            
            // NEXT SHIP
            nextShipTexture.texture = nextImage
            nextShipTexture.name = "NEXT_SHIP"
            nextShipTexture.size.width = 64
            nextShipTexture.size.height = 64
            nextShipTexture.position = CGPoint(x: w - 100, y: Int(Double(h) * 0.58))
            addChild(nextShipTexture)
            nextShipButton.name = "NEXT_SHIP"
            nextShipButton.position   = CGPoint(x:Int(Double(w) * 0.75), y: Int(Double(h) * 0.58))
            addChild(nextShipButton)
            
            // PREV SHIP
            prevShipTexture.texture = prevImage
            prevShipTexture.name = "PREV_SHIP"
            prevShipTexture.size.width = 64
            prevShipTexture.size.height = 64
            prevShipTexture.position = CGPoint(x: 100, y: Int(Double(h) * 0.58))
            addChild(prevShipTexture)
            prevShipButton.name = "PREV_SHIP"
            prevShipButton.position   = CGPoint(x:Int(Double(w) * 0.25), y: Int(Double(h) * 0.58))
            addChild(prevShipButton)
            
            // NEXT THRUSTER
            nextThrusterTexture.texture = nextImage
            nextThrusterTexture.name = "NEXT_THRUSTER"
            nextThrusterTexture.size.width = 64
            nextThrusterTexture.size.height = 64
            nextThrusterTexture.position = CGPoint(x: w - 138, y: Int(Double(h) * 0.40))
            addChild(nextThrusterTexture)
            nextThrusterButton.name = "NEXT_THRUSTER"
            nextThrusterButton.position   = CGPoint(x:Int(Double(w) * 0.65), y: Int(Double(h) * 0.40))
            addChild(nextThrusterButton)
            
            // PREV THRUSTER
            prevThrusterTexture.texture = prevImage
            prevThrusterTexture.name = "PREV_THRUSTER"
            prevThrusterTexture.size.width = 64
            prevThrusterTexture.size.height = 64
            prevThrusterTexture.position = CGPoint(x: 138, y: Int(Double(h) * 0.40))
            addChild(prevThrusterTexture)
            prevThrusterButton.name = "PREV_THRUSTER"
            prevThrusterButton.position   = CGPoint(x:Int(Double(w) * 0.35), y: Int(Double(h) * 0.40))
            addChild(prevThrusterButton)
            
            zPosition = 3
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {

        }
    }
}
