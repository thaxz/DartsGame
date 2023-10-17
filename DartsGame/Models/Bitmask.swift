//
//  Bitmask.swift
//  DartChallenge
//
//  Created by thaxz on 17/10/23.
//

import Foundation

struct CollisionCategory: OptionSet {
    let rawValue: Int
    
    static let darts  = CollisionCategory(rawValue: 1 << 0) // 00...01
    static let dartBoard = CollisionCategory(rawValue: 1 << 1) // 00..10
}
