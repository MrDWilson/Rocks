//
//  REColour.swift
//  Rocks
//
//  Created by user on 19/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import SpriteKit

extension GameScene {
    enum StarColour: Int {
        case white         = 0
        case blue           = 1
        case pink           = 2
        case COLOUR_BOUNDRY = 3
        
        var toUIColor: UIColor {
            switch (self) {
            case .white:            return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            case .blue:             return UIColor(red: 0.8, green: 1.0, blue: 1.0, alpha: 1.0)
            case .pink:             return UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0)
            case .COLOUR_BOUNDRY:   return UIColor.white
            default:  return UIColor.white
            }
        }
    }
    
    enum GeneralColour: Int {
        case clear         = 0
        case COLOUR_BOUNDRY = 1
        
        var toUIColor: UIColor {
            switch (self) {
            case .clear:            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            case .COLOUR_BOUNDRY:   return UIColor.white
            default:  return UIColor.white
            }
        }
        
        var nextColour: GeneralColour {
            if (self.rawValue == GeneralColour.COLOUR_BOUNDRY.rawValue) {return GeneralColour.init(rawValue: 0)!}
            else {return GeneralColour.init(rawValue: self.rawValue + 1)!}
        }
        
        var prevColour: GeneralColour {
            if (self.rawValue == 0) {return GeneralColour.init(rawValue: GeneralColour.COLOUR_BOUNDRY.rawValue - 1)!}
            else {return GeneralColour.init(rawValue: self.rawValue - 1)!}
        }
    }
    
    enum LaserColour: Int {
        case purple         = 0
        case cyan           = 1
        case red            = 2
        case magenta        = 3
        case green          = 4
        case COLOUR_BOUNDRY = 5
    
        var toUIColor: UIColor {
            switch (self) {
                case .purple:          return UIColor.purple
                case .cyan:            return UIColor.cyan
                case .red:             return UIColor.red
                case .magenta:         return UIColor.magenta
                case .green:           return UIColor.green
                case .COLOUR_BOUNDRY:   return UIColor.white
                default:  return UIColor.white
            }
        }
        
        var nextColour: LaserColour {
            if (self.rawValue == LaserColour.COLOUR_BOUNDRY.rawValue) {return LaserColour.init(rawValue: 0)!}
            else {return LaserColour.init(rawValue: self.rawValue + 1)!}
        }
        
        var prevColour: LaserColour {
            if (self.rawValue == 0) {return LaserColour.init(rawValue: LaserColour.COLOUR_BOUNDRY.rawValue - 1)!}
            else {return LaserColour.init(rawValue: self.rawValue - 1)!}
        }
    }
    
    enum BodyColour: Int {
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
        case gold           = 11
        case COLOUR_BOUNDRY = 12
        
        var toUIColor: UIColor {
            switch (self) {
                case .black:      return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
                case .darkGray:   return UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.0)
                case .mediumGray: return UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1.0)
                case .lightGray:  return UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.0)
                case .white:      return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                case .red:        return UIColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 1.0)
                case .green:      return UIColor(red: 0.2, green: 0.2, blue: 0.0, alpha: 1.0)
                case .blue:       return UIColor(red: 0.0, green: 0.2, blue: 0.30196, alpha: 1.0)
                case .lightBlue:  return UIColor(red: 0.7019, green: 0.925, blue: 1, alpha: 1.0)
                case .lightRed:   return UIColor(red: 1.0, green: 0.678, blue: 0.6, alpha: 1.0)
                case .pink:       return UIColor.magenta
                case .gold:       return UIColor.brown
                default:  return UIColor.white
            }
        }
        
        var nextColour: BodyColour {
            if (self.rawValue == BodyColour.COLOUR_BOUNDRY.rawValue) {return BodyColour.init(rawValue: 0)!}
            else {return BodyColour.init(rawValue: self.rawValue + 1)!}
        }
        
        var prevColour: BodyColour {
            if (self.rawValue == 0) {return BodyColour.init(rawValue: BodyColour.COLOUR_BOUNDRY.rawValue - 1)!}
            else {return BodyColour.init(rawValue: self.rawValue - 1)!}
        }
    }
}
