//
//  LocalisedStringMachine.swift
//  Rocks
//
//  Created by user on 21/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import Foundation

extension GameScene {
    enum Language {
        case english
        case japanese
    }
    
    class LocalisedStringMachine {
        private static var language = Language.english
        
        private static var english: [String] = [
            "Rocks", "customise ship", "leaderboard",
            "options", "vibra1tion", "sound", "language",
            "about", "version", "authors", "ammo", "health"
        ]
        
        private static var japanese: [String] = [
            "Rocks", "船をカスタマイズする", "リーダーボード",
            "オプション", "振動", "音", "言語", "約", "バージョン",
            "著者", "弾薬", "健康"
        ]
        
        static func getString(string: String) -> String {
            switch (language) {
            case .english:  return string
            case .japanese: return japanese [english.index(of: string)!]
            }
        }
        
        static func changeLanguage (lan: Language) {
            self.language = lan
        }
    }
}
