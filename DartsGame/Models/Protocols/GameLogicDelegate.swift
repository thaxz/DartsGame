//
//  GameLogicDelegate.swift
//  DartsGame
//
//  Created by thaxz on 17/10/23.
//

import Foundation

// MARK: A protocol defining score operations.
protocol GameLogicDelegate {
    
    /// Notifies the delegate that the total score has been updated.
    /// - totalScore: The updated total score.
    var totalScore: Int { get }
    mutating func addPoint() -> Void
    
}
