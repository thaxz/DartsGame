//
//  GameViewModel.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation

// MARK: View model for managing game logic and data in the App
class GameViewModel: ObservableObject {
    
    @Published var throwNumber: Int = 0
    @Published var isGameOver: Bool = false
    @Published var isPaused: Bool = false
    @Published var dartResults: [Bool]
    
    @Published var matches: [Match] = []
    
    let manager = CoreDataManager.shared
    
    init() {
        self.dartResults = Array(repeating: false, count: 5)
        fetchMatches()
    }
    
    var match: Match?
    
    var startTime: Date? = nil
    var endTime: Date? = nil
    var points: Int = 0
    
    //MARK:  Game Logic
    
    /// Handles the logic when a dart is thrown during the game.
    func throwDart(){
        if throwNumber < 5 {
            ARManager.shared.actionsStream.send(.placeDart)
            throwNumber += 1
            if throwNumber >= 5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.gameOver()
                }
            }
        }
    }
    
    /// Updates the result of a dart throw at the specified index
    func updateDartResult(at index: Int) {
        guard index >= 0, index < dartResults.count else {
            return // Index out of array bounds
        }
        dartResults[index] = true // Replaces the value at the specified index
    }
    
    /// Handles the logic when the game is over.
    func gameOver(){
        isGameOver = true
        endTime = Date()
        createMatch()
    }
    
    //MARK: Helpers
    
    /// Converts a boolean array to a string representation.
    /// - Parameter boolArray: An array of boolean values to be converted to a string.
    /// - Returns: A string representation of the boolean array.
    func boolArrayToString(_ boolArray: [Bool]) -> String {
        let stringArray = boolArray.map { String($0) }
        return "[" + stringArray.joined(separator: ", ") + "]"
    }
    
    /// Calculates the time difference between two dates and returns a formatted string.
    /// - Parameters:
    ///   - startDate: The starting date.
    ///   - endDate: The ending date.
    /// - Returns: A string representing the time difference between the two dates.
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
