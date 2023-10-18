//
//  GameViewModel.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation

class GameViewModel: ObservableObject {
    
    @Published var throwNumber: Int = 0
    
    @Published var isGameOver: Bool = false
    @Published var isPaused: Bool = false
    @Published var dartResults: [Bool] = []
    
    var match: Match?
    
    var startTime: Date? = nil
    var endTime: Date? = nil
    var points: Int = 0
    
    func gameOver(){
        isGameOver = true
        endTime = Date()
        createMatch()
    }
    
    // mock match
    func createMatch(){
        guard let endTime = endTime,
              let startTime = startTime else {
            return
        }
        let timePassed = calculateDifferenceString(between: startTime, and: endTime)
        
        self.match = Match(points: self.points, dartStatus: [true, false, true, true, false], timePassed: timePassed)
    }
    
    func calculateDifferenceString(between startDate: Date, and endDate: Date) -> String {
        let differenceInSeconds = Int(endDate.timeIntervalSince(startDate))
        if differenceInSeconds < 60 {
            return "\(differenceInSeconds) Seconds"
        } else {
            let differenceInMinutes = differenceInSeconds / 60
            return "\(differenceInMinutes) Minutes"
        }
    }
    
}
