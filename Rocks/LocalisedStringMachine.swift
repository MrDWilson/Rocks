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
        private var english  = [String]()
        private var japanese = [String]()
        
        private var language = Language.english
        
        init () {
            english.append("Rocks")
            english.append("customise ship")
            english.append("leaderboard")
            english.append("options")
            english.append("vibraation")
            english.append("sound")
            english.append("language")
            english.append("about")
            english.append("version")
            english.append("authors")
            
            japanese.append("岩")
            japanese.append("船をカスタマイズする")
            japanese.append("リーダーボード")
            japanese.append("オプション")
            japanese.append("振動")
            japanese.append("音")
            japanese.append("言語")
            japanese.append("約")
            japanese.append("バージョン")
            japanese.append("著者")
        }
        
        func getString(stringID: Int) -> String {
            switch (language) {
                case .english:  return english[stringID]
                case .japanese: return japanese[stringID]
            }
        }
    }
}
