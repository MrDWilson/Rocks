/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  OptionsScreen.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import SpriteKit

extension GameScene {
    class OptionsScreen: SKNode {
        private var backLabel  = SKLabelNode()
        private var backButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 200, height: 100))
        
        private var vibrateImage = SKSpriteNode()
        private var vibrate_on   = SKTexture(imageNamed: "vibrate_on")
        private var vibrate_off  = SKTexture(imageNamed: "vibrate_off")
        private var vibrateLabel = SKLabelNode()
        private var vibrateButton: SKSpriteNode!
        
        private var soundImage = SKSpriteNode()
        private var sound_on   = SKTexture(imageNamed: "sound_on")
        private var sound_off  = SKTexture(imageNamed: "sound_off")
        private var soundLabel = SKLabelNode()
        private var soundButton: SKSpriteNode!
        
        func toggleVibrate () {
            if (vibrateImage.texture == vibrate_on) { vibrateImage.texture = vibrate_off }
            else { vibrateImage.texture = vibrate_on }
        }
        
        func toggleSound () {
            if (soundImage.texture == sound_on) { soundImage.texture = sound_off }
            else { soundImage.texture = sound_on }
        }
        
        init (w: Int, h: Int, p: Player) {
            super.init()
            
            // back button
            backLabel.text = String("back")
            backLabel.horizontalAlignmentMode = .left
            backLabel.position = CGPoint(x: 10, y: h - 50)
            //addChild(backLabel)
            
            backButton.name = String("back")
            backButton.position = CGPoint(x: 10, y: h - 10)
            //addChild(backButton)
            
            // Vibrate
            vibrateImage.texture = vibrate_on
            vibrateImage.size = CGSize(width: 46, height: 32)
            vibrateImage.position = CGPoint(x: Int(Double(w) * 0.3), y: Int(Double(h) * 0.315))
            addChild(vibrateImage)
            vibrateImage.run(SKAction.colorize(with: UIColor.lightGray, colorBlendFactor: 1.0, duration: 0))
            
            vibrateLabel.text = String("vibration")
            vibrateLabel.fontColor = .lightGray
            vibrateLabel.horizontalAlignmentMode = .left
            vibrateLabel.position = CGPoint(x: Int(Double(w) * 0.5), y:  Int(Double(h) * 0.3))
            addChild(vibrateLabel)
            
            vibrateButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: w, height: 60))
            vibrateButton.name = String("vibration")
            vibrateButton.position = CGPoint(x: w / 2, y:  Int(Double(h) * 0.3))
            addChild(vibrateButton)
            
            // sound
            soundImage.texture = sound_on
            soundImage.size = CGSize(width: 36, height: 32)
            soundImage.position = CGPoint(x: Int(Double(w) * 0.3), y: Int(Double(h) * 0.165))
            addChild(soundImage)
            soundImage.run(SKAction.colorize(with: UIColor.lightGray, colorBlendFactor: 1.0, duration: 0))
            
            soundLabel.text = String("sound")
            soundLabel.fontColor = .lightGray
            soundLabel.horizontalAlignmentMode = .left
            soundLabel.position = CGPoint(x: Int(Double(w) * 0.5), y:  Int(Double(h) * 0.15))
            addChild(soundLabel)
            
            soundButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: w, height: 60))
            soundButton.name = String("sound")
            soundButton.position = CGPoint(x: w / 2, y:  Int(Double(h) * 0.15))
            addChild(soundButton)
            
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func update () {
            
        }
    }
}
