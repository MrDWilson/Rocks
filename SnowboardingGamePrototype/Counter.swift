//
//  Counter.swift
//  SnowboardingGamePrototype
//
//  Created by Ryan Needham on 08/11/2016.
//  Copyright © 2016 Ryan Needham. All rights reserved.
//

import Foundation

extension GameScene {
    class Counter {
        var count = 0
        func increment() {
            count += 1
        }
        func reset() {
            count = 0
        }
        func getCount() -> Int {
            return count
        }
    }
}
