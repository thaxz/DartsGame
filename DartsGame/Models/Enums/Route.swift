//
//  Route.swift
//  DartChallenge
//
//  Created by thaxz on 13/10/23.
//

import Foundation
import SwiftUI

enum Route {
    
    // Navigation cases
    /// Put every screen here and if needs an objects, pass it ike this case yourItem(item: MyItem)
    case game
    case pause
    case endMatch(match: Match)
    case matchDetails(match: Match)
    case previousMatches(matches: [Match])
}

// MARK: Separating View Builders

extension Route: View {
    // Building Views according to switch self
    var body: some View {
        switch self {
        case .game:
            GameView()
        case .pause:
            PauseView()
        case .endMatch(let match):
            EndMatchView(match: match)
        case .matchDetails(let match):
            DetailView(match: match)
        case .previousMatches:
            PreviousMatchesView()
        }
    }
}

// MARK: Separating hashable protocol

extension Route: Hashable {
    
    // conforming to hashable protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    // conforming to equatable protocol
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs){
        case (.game, .game):
            return true
        case (.pause, .pause):
            return true
        case (.endMatch(let lshItem), .endMatch(let rhsItem)):
            return lshItem.id == rhsItem.id
        case (.matchDetails(let lshItem), .matchDetails(let rhsItem)):
            return lshItem.id == rhsItem.id
        case (.previousMatches, .previousMatches):
            return true
        default:
            return false
        }
    }

}
