/* * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  Counter.swift
 *  Space Game
 *
 *  Created by Ryan Needham & Danny Wilson on 07/11/2016.
 *  Copyright © 2016 Ryan Needham & Danny Wilson.
 *  All rights reserved.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

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
