//
//  Bitmask.swift
//  DartChallenge
//
//  Created by thaxz on 17/10/23.
//

import Foundation

// MARK: Collision categories for physics interactions

struct CollisionCategory: OptionSet {
    
    let rawValue: Int
    
    /// Dart collision
    static let darts  = CollisionCategory(rawValue: 1 << 0) // 00...01
    /// Board collision
    static let dartBoard = CollisionCategory(rawValue: 1 << 1) // 00..10
}
