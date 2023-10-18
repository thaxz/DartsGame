//
//  Route.swift
//  DartChallenge
//
//  Created by thaxz on 13/10/23.
//

import Foundation
import SwiftUI

// MARK: Enum representing different screens in the app's navigation flow.
enum Route {
    
    // Navigation cases
    /// Put every screen here and if needs an object, pass it ike this 'case yourItem(item: MyItem)
    case game
    case help
    case pause
    case endMatch(match: Match?)
    case matchDetails(match: Match?)
    case previousMatches
}

// MARK: - View and Hashable Conformance

extension Route: View {
    /// A SwiftUI View representation of the current Route.
    ///
    var body: some View {
        switch self {
        case .game:
            GameView()
        case .help:
            HelpView()
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
    
    /// Generates a hash value for the enum cases to conform to the Hashable protocol.
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    /// Compares enum cases for equality to conform to the Equatable protocol.
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs){
        case (.game, .game):
            return true
        case (.help, .help):
            return true
        case (.pause, .pause):
            return true
        case (.endMatch(let lshItem), .endMatch(let rhsItem)):
            return lshItem?.uuid == rhsItem?.uuid
        case (.matchDetails(let lshItem), .matchDetails(let rhsItem)):
            return lshItem?.uuid == rhsItem?.uuid
        case (.previousMatches, .previousMatches):
            return true
        default:
            return false
        }
    }

}
