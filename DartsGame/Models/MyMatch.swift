//
//  Match.swift
//  DartChallenge
//
//  Created by thaxz on 13/10/23.
//

import Foundation

struct MyMatch: Identifiable, Hashable {
    
    let id: Int
    let points: Int
    var dartStatus: String
    let timePassed: String
    
}

let mockMatches: [MyMatch] = [
    MyMatch(id: 1, points: 3, dartStatus: "[false, true, true, false, true]", timePassed: "60"),
    MyMatch(id: 2, points: 5, dartStatus: "[true, true, true, true, true]", timePassed: "120"),
    
]

let testMacthes: [MyMatch] = []
