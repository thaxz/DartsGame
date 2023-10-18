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
    
    func updateDartResult(at index: Int) {
        guard index >= 0, index < dartResults.count else {
            return // Índice fora do intervalo do array
        }
        dartResults[index] = true // Substitui o valor no índice especificado
    }
    
    func gameOver(){
        isGameOver = true
        endTime = Date()
        createMatch()
    }
    
    //MARK: Helpers
    
    func boolArrayToString(_ boolArray: [Bool]) -> String {
        let stringArray = boolArray.map { String($0) }
        return "[" + stringArray.joined(separator: ", ") + "]"
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
