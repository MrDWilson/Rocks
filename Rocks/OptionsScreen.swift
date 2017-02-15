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
        
        private var vibrateY: CGFloat!
        private var vibrateImage = SKSpriteNode()
        private var vibrate_on   = SKTexture(imageNamed: "vibrate_on")
        private var vibrate_off  = SKTexture(imageNamed: "vibrate_off")
        private var vibrateLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private var vibrateButton: SKSpriteNode!
        
        private var soundY: CGFloat!
        private var soundImage = SKSpriteNode()
        private var sound_on   = SKTexture(imageNamed: "sound_on")
        private var sound_off  = SKTexture(imageNamed: "sound_off")
        private var soundLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-UltraLight")
        private var soundButton: SKSpriteNode!
        
        private var screenWidth: CGFloat!
        private var screenHeight: CGFloat!
        
        func toggleVibrate () {
            if (vibrateImage.texture == vibrate_on) { vibrateImage.texture = vibrate_off }
            else { vibrateImage.texture = vibrate_on }
            
        }
        
        func toggleSound () {
            if (soundImage.texture == sound_on) { soundImage.texture = sound_off }
            else { soundImage.texture = sound_on }
        }
        
        init (w: Int, h: Int, p: Player, sound: Bool, vibrate: Bool) {
            super.init()
            
            vibrateY = CGFloat(Double(h) * 0.3)
            soundY = CGFloat(Double(h) * 0.15)
            
            screenWidth = CGFloat(w)
            screenHeight = CGFloat(h)
            
            // back button
            backLabel.text = String("back")
            backLabel.horizontalAlignmentMode = .left
            backLabel.position = CGPoint(x: 10, y: h - 50)
            //addChild(backLabel)
            
            backButton.name = String("back")
            backButton.position = CGPoint(x: 10, y: h - 10)
            //addChild(backButton)
            
            // Vibrate
            if (vibrate) {vibrateImage.texture = vibrate_on} else {vibrateImage.texture = vibrate_off}
            vibrateImage.size = CGSize(width: 46, height: 32)
            vibrateImage.position = CGPoint(x: Int(Double(w) * 0.3), y: 0)
            addChild(vibrateImage)
            vibrateImage.run(SKAction.colorize(with: UIColor.lightGray, colorBlendFactor: 1.0, duration: 0))
            
            vibrateLabel.text = String("vibration")
            vibrateLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            vibrateLabel.horizontalAlignmentMode = .left
            vibrateLabel.position = CGPoint(x: Int(Double(w) * 0.5), y:  0)
            addChild(vibrateLabel)
            
            vibrateButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: w, height: 60))
            vibrateButton.name = String("vibration")
            vibrateButton.position = CGPoint(x: w / 2, y:  0)
            addChild(vibrateButton)
            
            // sound
            if (sound) {soundImage.texture = sound_on} else {soundImage.texture = sound_off}
            soundImage.size = CGSize(width: 36, height: 32)
            soundImage.position = CGPoint(x: Int(Double(w) * 0.3), y: 0)
            addChild(soundImage)
            soundImage.run(SKAction.colorize(with: UIColor.lightGray, colorBlendFactor: 1.0, duration: 0))
            
            soundLabel.text = String("sound")
            soundLabel.fontColor = UIColor(red: 0.93, green: 0.90, blue: 0.83, alpha: 1)
            soundLabel.horizontalAlignmentMode = .left
            soundLabel.position = CGPoint(x: Int(Double(w) * 0.5), y: 0)
            addChild(soundLabel)
            
            soundButton = SKSpriteNode(color: UIColor.clear, size: CGSize(width: w, height: 60))
            soundButton.name = String("sound")
            soundButton.position = CGPoint(x: w / 2, y: 0)
            addChild(soundButton)
            
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func show () {
            isHidden = false
            vibrateY = CGFloat(Double(screenHeight) * 0.3)
            soundY = CGFloat(Double(screenHeight) * 0.15)
        }
        
        func hide () {
            isHidden = true
            vibrateY = 0
            soundY = 0            
        }
        
        func update () {
            let speed: CGFloat = 0.16
        
            // VIBRATE LABEL
            if (vibrateLabel.position.y < vibrateY - 6) {
                vibrateLabel.position.y  += (vibrateY - vibrateLabel.position.y) * speed
                vibrateButton.position.y += (vibrateY - vibrateButton.position.y) * speed
            }
            
            if (vibrateLabel.position.y > vibrateY + 6) {
                vibrateLabel.position.y  -= (vibrateLabel.position.y - vibrateY) * speed
                vibrateButton.position.y -= (vibrateButton.position.y - vibrateY) * speed
            }
            
            if (vibrateImage.position.y < vibrateY) {
                vibrateImage.position.y += ((vibrateY) - vibrateImage.position.y) * speed
            }
            
            if (vibrateImage.position.y > vibrateY) {
                vibrateImage.position.y -= (vibrateImage.position.y - (vibrateY)) * speed
            }
            
            // sound LABEL
            if (soundLabel.position.y < soundY - 6) {
                soundLabel.position.y  += (soundY - soundLabel.position.y) * speed
                soundButton.position.y += (soundY - soundButton.position.y) * speed
            }
            
            if (soundLabel.position.y > soundY + 6) {
                soundLabel.position.y  -= (soundLabel.position.y - soundY) * speed
                soundButton.position.y -= (soundButton.position.y - soundY) * speed
            }
            
            if (soundImage.position.y < soundY) {
                soundImage.position.y += ((soundY) - soundImage.position.y) * speed
            }
            
            if (soundImage.position.y > soundY) {
                soundImage.position.y -= (soundImage.position.y - (soundY)) * speed
            }
            
        }
    }
}
