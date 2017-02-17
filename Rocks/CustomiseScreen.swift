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
/*
        private var nextLaserTexture = SKSpriteNode()
        private let nextLaserButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        private let prevLaserTexture = SKSpriteNode()
        private let prevLaserButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        private var nextShipTexture = SKSpriteNode()
        private let nextShipButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        private let prevShipTexture = SKSpriteNode()
        private let prevShipButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        private var nextThrusterTexture = SKSpriteNode()
        private let nextThrusterButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        private var prevThrusterTexture = SKSpriteNode()
        private let prevThrusterButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
*/

        // NEW SETUP
        private var nextX: CGFloat!
        private var prevX: CGFloat!
        
        // RANDOMISE BUTTON NEEDED
        // COLOUR BUTTONS NEEDED
     
        private var bodyY: CGFloat!
        private let bodyLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        private var nextBodyTexture = SKSpriteNode()
        private let nextBodyButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        private let prevBodyTexture = SKSpriteNode()
        private let prevBodyButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
    
        private var leftWingY: CGFloat!
        private let leftWingLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        private var nextLeftWingTexture = SKSpriteNode()
        private let nextLeftWingButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        private let prevLeftWingTexture = SKSpriteNode()
        private let prevLeftWingButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        private var rightWingY: CGFloat!
        private let rightWingLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        private var nextRightWingTexture = SKSpriteNode()
        private let nextRightWingButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        private let prevRightWingTexture = SKSpriteNode()
        private let prevRightWingButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        private var energyColourY: CGFloat!
        private let energyColourLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        private var nextEnergyColourTexture = SKSpriteNode()
        private let nextEnergyColourButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        private let prevEnergyColourTexture = SKSpriteNode()
        private let prevEnergyColourButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        private var bodyColourY: CGFloat!
        private let bodyColourLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-Light")
        private var nextBodyColourTexture = SKSpriteNode()
        private let nextBodyColourButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        private let prevBodyColourTexture = SKSpriteNode()
        private let prevBodyColourButton  = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 128, height: 128))
        
        // GENERAL
        private let nextImage = SKTexture(imageNamed: "next")
        private let prevImage = SKTexture(imageNamed: "previous")
        
        private var player: Player!
        
        private var screenWidth: CGFloat!
        private var screenHeight: CGFloat!
        
        init (w: Int, h: Int, p: Player) {
            super.init()
            
            player = p
            
            screenWidth = CGFloat(w)
            screenHeight = CGFloat(h)
            
            nextX = CGFloat(Double(w) * 0.85)
            prevX = CGFloat(Double(w) * 0.15)
            
            /** 
             *  BODY
             */
            bodyY = CGFloat(Double(h) * 0.04)
            bodyLabel.text = String("body")
            bodyLabel.fontSize = 22
            bodyLabel.horizontalAlignmentMode = .center
            bodyLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            bodyLabel.position = CGPoint(x: w / 2, y: Int(bodyY))
            addChild(bodyLabel)

            // NEXT Body
            nextBodyTexture.texture = nextImage
            nextBodyTexture.name = "NEXT_BODY"
            nextBodyTexture.size.width = 64
            nextBodyTexture.size.height = 64
            nextBodyTexture.position = CGPoint(x: Int(nextX), y: Int(bodyY))
            addChild(nextBodyTexture)
            
            nextBodyButton.name = "NEXT_BODY"
            nextBodyButton.color = UIColor.clear
            nextBodyButton.position = CGPoint(x:Int(nextX), y: Int(bodyY))
            addChild(nextBodyButton)
            
            // PREV Body
            prevBodyTexture.texture = prevImage
            prevBodyTexture.name = "PREV_BODY"
            prevBodyTexture.size.width = 64
            prevBodyTexture.size.height = 64
            prevBodyTexture.position = CGPoint(x: Int(prevX), y: Int(bodyY))
            addChild(prevBodyTexture)
            
            prevBodyButton.name = "PREV_BODY"
            prevBodyButton.color = UIColor.clear
            prevBodyButton.position   = CGPoint(x:Int(prevX), y: Int(bodyY))
            addChild(prevBodyButton)
            
            /**
             *  LEFT WING
             */
            leftWingY = CGFloat(Double(h) * 0.12)
            leftWingLabel.text = String("left wing")
            leftWingLabel.fontSize = 22
            leftWingLabel.horizontalAlignmentMode = .center
            leftWingLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            leftWingLabel.position = CGPoint(x: w / 2, y: Int(leftWingY))
            addChild(leftWingLabel)
            
            // NEXT leftWing
            nextLeftWingTexture.texture = nextImage
            nextLeftWingTexture.name = "NEXT_LWING"
            nextLeftWingTexture.size.width = 64
            nextLeftWingTexture.size.height = 64
            nextLeftWingTexture.position = CGPoint(x: Int(nextX), y: Int(leftWingY))
            addChild(nextLeftWingTexture)
            
            nextLeftWingButton.name = "NEXT_LWING"
            nextLeftWingButton.color = UIColor.clear
            nextLeftWingButton.position = CGPoint(x:Int(nextX), y: Int(leftWingY))
            addChild(nextLeftWingButton)
            
            // PREV leftWing
            prevLeftWingTexture.texture = prevImage
            prevLeftWingTexture.name = "PREV_LWING"
            prevLeftWingTexture.size.width = 64
            prevLeftWingTexture.size.height = 64
            prevLeftWingTexture.position = CGPoint(x: Int(prevX), y: Int(leftWingY))
            addChild(prevLeftWingTexture)
            
            prevLeftWingButton.name = "PREV_LWING"
            prevLeftWingButton.color = UIColor.clear
            prevLeftWingButton.position   = CGPoint(x: Int(prevX), y: Int(leftWingY))
            addChild(prevLeftWingButton)

            /**
             *  RIGHT WING
             */
            rightWingY = CGFloat(Double(h) * 0.20)
            rightWingLabel.text = String("right wing")
            rightWingLabel.fontSize = 22
            rightWingLabel.horizontalAlignmentMode = .center
            rightWingLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            rightWingLabel.position = CGPoint(x: w / 2, y: Int(rightWingY))
            addChild(rightWingLabel)
            
            // NEXT right Wing
            nextRightWingTexture.texture = nextImage
            nextRightWingTexture.name = "NEXT_RWING"
            nextRightWingTexture.size.width = 64
            nextRightWingTexture.size.height = 64
            nextRightWingTexture.position = CGPoint(x: Int(nextX), y: Int(rightWingY))
            addChild(nextRightWingTexture)
            
            nextRightWingButton.name = "NEXT_RWING"
            nextRightWingButton.color = UIColor.clear
            nextRightWingButton.position = CGPoint(x:Int(nextX), y: Int(rightWingY))
            addChild(nextRightWingButton)
            
            // PREV right Wing
            prevRightWingTexture.texture = prevImage
            prevRightWingTexture.name = "PREV_RWING"
            prevRightWingTexture.size.width = 64
            prevRightWingTexture.size.height = 64
            prevRightWingTexture.position = CGPoint(x: Int(prevX), y: Int(rightWingY))
            addChild(prevRightWingTexture)
            
            prevRightWingButton.name = "PREV_LWING"
            prevRightWingButton.color = UIColor.clear
            prevRightWingButton.position   = CGPoint(x:Int(prevX), y: Int(rightWingY))
            addChild(prevRightWingButton)
            
            /**
             *  ENERGY COLOUR
             */
            energyColourY = CGFloat(Double(h) * 0.28)
            energyColourLabel.text = String("core colour")
            energyColourLabel.fontSize = 22
            energyColourLabel.horizontalAlignmentMode = .center
            energyColourLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            energyColourLabel.position = CGPoint(x: w / 2, y: Int(energyColourY))
            addChild(energyColourLabel)
            
            // NEXT right Wing
            nextEnergyColourTexture.texture = nextImage
            nextEnergyColourTexture.name = "NEXT_CORE"
            nextEnergyColourTexture.size.width = 64
            nextEnergyColourTexture.size.height = 64
            nextEnergyColourTexture.position = CGPoint(x: Int(nextX), y: Int(energyColourY))
            addChild(nextEnergyColourTexture)
            
            nextEnergyColourButton.name = "NEXT_CORE"
            nextEnergyColourButton.color = UIColor.clear
            nextEnergyColourButton.position = CGPoint(x:Int(nextX), y: Int(energyColourY))
            addChild(nextEnergyColourButton)
            
            // PREV right Wing
            prevEnergyColourTexture.texture = prevImage
            prevEnergyColourTexture.name = "PREV_CORE"
            prevEnergyColourTexture.size.width = 64
            prevEnergyColourTexture.size.height = 64
            prevEnergyColourTexture.position = CGPoint(x: Int(prevX), y: Int(energyColourY))
            addChild(prevEnergyColourTexture)
            
            prevEnergyColourButton.name = "PREV_CORE"
            prevEnergyColourButton.color = UIColor.clear
            prevEnergyColourButton.position   = CGPoint(x:Int(prevX), y: Int(energyColourY))
            addChild(prevEnergyColourButton)

/*
            // NEXT LASER
            nextLaserTexture.texture = nextImage
            nextLaserTexture.name = "NEXT_LASER"
            nextLaserTexture.size.width = 64
            nextLaserTexture.size.height = 64
            nextLaserTexture.position = CGPoint(x: w - 100, y: Int(Double(h) * 0.68))
            addChild(nextLaserTexture)
            nextLaserButton.name = "NEXT_LASER"
            nextLaserButton.position = CGPoint(x:Int(Double(w) * 0.75), y: Int(Double(h) * 0.68))
            addChild(nextLaserButton)
            
            // PREV LASER
            prevLaserTexture.texture = prevImage
            prevLaserTexture.name = "PREV_LASER"
            prevLaserTexture.size.width = 64
            prevLaserTexture.size.height = 64
            prevLaserTexture.position = CGPoint(x: 100, y: Int(Double(h) * 0.68))
            addChild(prevLaserTexture)
            prevLaserButton.name = "PREV_LASER"
            prevLaserButton.position   = CGPoint(x:Int(Double(w) * 0.25), y: Int(Double(h) * 0.68))
            addChild(prevLaserButton)
            
            // NEXT SHIP
            nextShipTexture.texture = nextImage
            nextShipTexture.name = "NEXT_SHIP"
            nextShipTexture.size.width = 64
            nextShipTexture.size.height = 64
            nextShipTexture.position = CGPoint(x: w - 100, y: Int(Double(h) * 0.50))
            addChild(nextShipTexture)
            nextShipButton.name = "NEXT_SHIP"
            nextShipButton.position   = CGPoint(x:Int(Double(w) * 0.75), y: Int(Double(h) * 0.50))
            addChild(nextShipButton)
            
            // PREV SHIP
            prevShipTexture.texture = prevImage
            prevShipTexture.name = "PREV_SHIP"
            prevShipTexture.size.width = 64
            prevShipTexture.size.height = 64
            prevShipTexture.position = CGPoint(x: 100, y: Int(Double(h) * 0.50))
            addChild(prevShipTexture)
            prevShipButton.name = "PREV_SHIP"
            prevShipButton.position   = CGPoint(x:Int(Double(w) * 0.25), y: Int(Double(h) * 0.50))
            addChild(prevShipButton)
            
            // NEXT THRUSTER
            nextThrusterTexture.texture = nextImage
            nextThrusterTexture.name = "NEXT_THRUSTER"
            nextThrusterTexture.size.width = 64
            nextThrusterTexture.size.height = 64
            nextThrusterTexture.position = CGPoint(x: w - 138, y: Int(Double(h) * 0.32))
            addChild(nextThrusterTexture)
            nextThrusterButton.name = "NEXT_THRUSTER"
            nextThrusterButton.position   = CGPoint(x:Int(Double(w) * 0.65), y: Int(Double(h) * 0.32))
            addChild(nextThrusterButton)
            
            // PREV THRUSTER
            prevThrusterTexture.texture = prevImage
            prevThrusterTexture.name = "PREV_THRUSTER"
            prevThrusterTexture.size.width = 64
            prevThrusterTexture.size.height = 64
            prevThrusterTexture.position = CGPoint(x: 138, y: Int(Double(h) * 0.32))
            addChild(prevThrusterTexture)
            prevThrusterButton.name = "PREV_THRUSTER"
            prevThrusterButton.position   = CGPoint(x:Int(Double(w) * 0.35), y: Int(Double(h) * 0.32))
            addChild(prevThrusterButton)
*/
            zPosition = 3
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func show () {
            isHidden = false
            bodyY = CGFloat(Double(screenHeight) * 0.04)
            leftWingY = CGFloat(Double(screenHeight) * 0.12)
            rightWingY = CGFloat(Double(screenHeight) * 0.20)
            energyColourY = CGFloat(Double(screenHeight) * 0.28)
            
            nextX = CGFloat(Double(screenWidth) * 0.85)
            prevX = CGFloat(Double(screenWidth) * 0.15)
        }
        
        func hide () {
            isHidden = false
            bodyY = -60
            leftWingY = -60
            rightWingY = -60
            energyColourY =  -60
            
            nextX = CGFloat(Double(screenWidth) + 50)
            prevX = CGFloat(-50)
        }
        
        func hardHide () {
            isHidden = true
            bodyY = -50
            leftWingY = -50
            rightWingY = -50
            energyColourY =  -50
            
            nextX = CGFloat(Double(screenWidth) + 50)
            prevX = CGFloat(-50)
        }
        
        func update () {
            //player.fireLaser()
            //player.pickupAmmo()
            let speed: CGFloat = 0.10
            
            // BODY
            if (bodyLabel.position.y < bodyY) { bodyLabel.position.y += (bodyY - bodyLabel.position.y) * speed }
            if (bodyLabel.position.y > bodyY) { bodyLabel.position.y -= (bodyLabel.position.y - bodyY) * speed }
            
            if (nextBodyTexture.position.x < nextX) { nextBodyTexture.position.x += (nextX - nextBodyTexture.position.x) * speed }
            if (nextBodyTexture.position.x > nextX) { nextBodyTexture.position.x -= (nextBodyTexture.position.x - nextX) * speed }
            
            if (nextBodyButton.position.y < bodyY) { nextBodyButton.position.y += (bodyY - nextBodyButton.position.y) * speed }
            if (nextBodyButton.position.y > bodyY) { nextBodyButton.position.y -= (nextBodyButton.position.y - bodyY) * speed }

            if (prevBodyTexture.position.y < prevX) { prevBodyTexture.position.x += (prevX - prevBodyTexture.position.x) * speed }
            if (prevBodyTexture.position.y > prevX) { prevBodyTexture.position.x -= (prevBodyTexture.position.x - prevX) * speed }
            
            if (prevBodyButton.position.y < bodyY) { prevBodyButton.position.y += (bodyY - prevBodyButton.position.y) * speed }
            if (prevBodyButton.position.y > bodyY) { prevBodyButton.position.y -= (prevBodyButton.position.y - bodyY) * speed }
            
            // LEFT WING
            if (leftWingLabel.position.y < leftWingY) { leftWingLabel.position.y += (leftWingY - leftWingLabel.position.y) * speed }
            if (leftWingLabel.position.y > leftWingY) { leftWingLabel.position.y -= (leftWingLabel.position.y - leftWingY) * speed }
            
            if (nextLeftWingTexture.position.x < nextX) { nextLeftWingTexture.position.x += (nextX - nextLeftWingTexture.position.x) * speed }
            if (nextLeftWingTexture.position.x > nextX) { nextLeftWingTexture.position.x -= (nextLeftWingTexture.position.x - nextX) * speed }
            
            if (nextLeftWingButton.position.y < leftWingY) { nextLeftWingButton.position.y += (leftWingY - nextLeftWingButton.position.y) * speed }
            if (nextLeftWingButton.position.y > leftWingY) { nextLeftWingButton.position.y -= (nextLeftWingButton.position.y - leftWingY) * speed }
            
            if (prevLeftWingTexture.position.y < prevX) { prevLeftWingTexture.position.x += (prevX - prevLeftWingTexture.position.x) * speed }
            if (prevLeftWingTexture.position.y > prevX) { prevLeftWingTexture.position.x -= (prevLeftWingTexture.position.x - prevX) * speed }
            
            if (prevLeftWingButton.position.y < leftWingY) { prevLeftWingButton.position.y += (leftWingY - prevLeftWingButton.position.y) * speed }
            if (prevLeftWingButton.position.y > leftWingY) { prevLeftWingButton.position.y -= (prevLeftWingButton.position.y - leftWingY) * speed }
            
            // RIGHT WING
            if (rightWingLabel.position.y < rightWingY) { rightWingLabel.position.y += (rightWingY - rightWingLabel.position.y) * speed }
            if (rightWingLabel.position.y > rightWingY) { rightWingLabel.position.y -= (rightWingLabel.position.y - rightWingY) * speed }
            
            if (nextRightWingTexture.position.x < nextX) { nextRightWingTexture.position.x += (nextX - nextRightWingTexture.position.x) * speed }
            if (nextRightWingTexture.position.x > nextX) { nextRightWingTexture.position.x -= (nextRightWingTexture.position.x - nextX) * speed }
            
            if (nextRightWingButton.position.y < rightWingY) { nextRightWingButton.position.y += (rightWingY - nextRightWingButton.position.y) * speed }
            if (nextRightWingButton.position.y > rightWingY) { nextRightWingButton.position.y -= (nextRightWingButton.position.y - rightWingY) * speed }
            
            if (prevRightWingTexture.position.y < prevX) { prevRightWingTexture.position.x += (prevX - prevRightWingTexture.position.x) * speed }
            if (prevRightWingTexture.position.y > prevX) { prevRightWingTexture.position.x -= (prevRightWingTexture.position.x - prevX) * speed }
            
            if (prevRightWingButton.position.y < rightWingY) { prevRightWingButton.position.y += (rightWingY - prevRightWingButton.position.y) * speed }
            if (prevRightWingButton.position.y > rightWingY) { prevRightWingButton.position.y -= (prevRightWingButton.position.y - rightWingY) * speed }
            
            // ENERGY
            if (energyColourLabel.position.y < energyColourY) { energyColourLabel.position.y += (energyColourY - energyColourLabel.position.y) * speed }
            if (energyColourLabel.position.y > energyColourY) { energyColourLabel.position.y -= (energyColourLabel.position.y - energyColourY) * speed }
            
            if (nextEnergyColourTexture.position.x < nextX) { nextEnergyColourTexture.position.x += (nextX - nextEnergyColourTexture.position.x) * speed }
            if (nextEnergyColourTexture.position.x > nextX) { nextEnergyColourTexture.position.x -= (nextEnergyColourTexture.position.x - nextX) * speed }
            
            if (nextEnergyColourButton.position.y < energyColourY) { nextEnergyColourButton.position.y += (energyColourY - nextEnergyColourButton.position.y) * speed }
            if (nextEnergyColourButton.position.y > energyColourY) { nextEnergyColourButton.position.y -= (nextEnergyColourButton.position.y - energyColourY) * speed }
            
            if (prevEnergyColourTexture.position.y < prevX) { prevEnergyColourTexture.position.x += (prevX - prevEnergyColourTexture.position.x) * speed }
            if (prevEnergyColourTexture.position.y > prevX) { prevEnergyColourTexture.position.x -= (prevEnergyColourTexture.position.x - prevX) * speed }
            
            if (prevEnergyColourButton.position.y < energyColourY) { prevEnergyColourButton.position.y += (energyColourY - prevEnergyColourButton.position.y) * speed }
            if (prevEnergyColourButton.position.y > energyColourY) { prevEnergyColourButton.position.y -= (prevEnergyColourButton.position.y - energyColourY) * speed }
        }
    }
}
