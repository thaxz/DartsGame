//
//  GameLogicDelegate.swift
//  DartsGame
//
//  Created by thaxz on 17/10/23.
//

import Foundation

protocol GameLogicDelegate {
    
    var totalScore: Int { get }
    mutating func addPoint() -> Void
}
