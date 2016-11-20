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
        case COLOUR_BOUNDRY = 12
        
        var toUIColor: UIColor {
            switch (self) {
            case .lightGray: return UIColor.lightGray
            case .white:     return UIColor.white
            case .gray:      return UIColor.gray
            case .red:       return UIColor.red
            case .green:     return UIColor.green
            case .blue:      return UIColor.blue
            case .cyan:      return UIColor.cyan
            case .yellow:    return UIColor.yellow
            case .magenta:   return UIColor.magenta
            case .orange:    return UIColor.orange
            case .purple:    return UIColor.purple
            case .brown:     return UIColor.brown
            default:         return UIColor.white
            }
        }
        
        var nextColour: REColour {
            switch (self) {
            case .lightGray: return .brown
            case .white:     return .lightGray
            case .gray:      return .white
            case .red:       return .gray
            case .green:     return .red
            case .blue:      return .green
            case .cyan:      return .blue
            case .yellow:    return .cyan
            case .magenta:   return .yellow
            case .orange:    return .magenta
            case .purple:    return .orange
            case .brown:     return .purple
            default:         return .white
            }
        }
        
        var prevColour: REColour {
            switch (self) {
            case .lightGray: return .white
            case .white:     return .gray
            case .gray:      return .red
            case .red:       return .green
            case .green:     return .blue
            case .blue:      return .cyan
            case .cyan:      return .yellow
            case .yellow:    return .magenta
            case .magenta:   return .orange
            case .orange:    return .purple
            case .purple:    return .brown
            case .brown:     return .lightGray
            default:         return .white
            }
        }
    }
}
