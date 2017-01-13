//
//  REColour.swift
//  Rocks
//
//  Created by user on 19/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit

extension GameScene {
    enum REColour: Int {
        case black          = 0
        case darkGray       = 1
        case mediumGray     = 2
        case lightGray      = 3
        case white          = 4
        case red            = 5
        case green          = 6
        case blue           = 7
        case lightBlue      = 8
        case lightRed       = 9
        case pink           = 10
        case COLOUR_BOUNDRY = 11
        
        /*
        case lightGray = 0
        case white     = 1
        case gray      = 2
        case red       = 3
        case green     = 4
        case blue      = 5
        case cyan      = 6
        case yellow    = 7
        case magenta   = 8
        case orange    = 9
        case purple    = 10
        case brown     = 11

        */
        
        var toUIColor: UIColor {
            switch (self) {
                case .black:      return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                case .darkGray:   return UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
                case .mediumGray: return UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1.0)
                case .lightGray:  return UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0)
                case .white:      return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                case .red:        return UIColor(red: 0.75, green: 0.1, blue: 0.1, alpha: 1.0)
                case .green:      return UIColor(red: 0.0, green: 0.75, blue: 0.0, alpha: 1.0)
                case .blue:       return UIColor(red: 0.0, green: 0.0, blue: 0.75, alpha: 1.0)
                case .lightBlue:       return UIColor(red: 0.34, green: 0.34, blue: 1, alpha: 1.0)
                case .lightRed:   return UIColor(red: 1.0, green: 0.34, blue: 0.34, alpha: 1.0)
                case .pink:       return UIColor.magenta
                default:  return UIColor.white
            }
        }
        
        var nextColour: REColour {
            if (self.rawValue == REColour.COLOUR_BOUNDRY.rawValue) {
                return REColour.init(rawValue: 0)!
            }
                
            else {
                return REColour.init(rawValue: self.rawValue + 1)!
            }
        }
        
        var prevColour: REColour {
            if (self.rawValue == 0) {
                return REColour.init(rawValue: REColour.COLOUR_BOUNDRY.rawValue - 1)!
            }
            
            else {
                return REColour.init(rawValue: self.rawValue - 1)!
            }
        }
    }
}
