//
//  Match.swift
//  DartChallenge
//
//  Created by thaxz on 13/10/23.
//

import Foundation

struct Match: Identifiable, Hashable {
    
    static var idCounter = 1
    var id: Int
    let points: Int
    var dartStatus: [Bool]
    let timePassed: Int
    
    init(points: Int, dartStatus: [Bool], timePassed: Int) {
        self.id = Match.idCounter
        Match.idCounter += 1
        self.points = points
        self.dartStatus = dartStatus
        self.timePassed = timePassed
    }
    
}

let mockMatches: [Match] = [
    Match(points: 3, dartStatus: [false, true, true, false, true], timePassed: 60),
    Match(points: 5, dartStatus: [true, true, true, true, true], timePassed: 120),
    
]

let testMacthes: [Match] = []
