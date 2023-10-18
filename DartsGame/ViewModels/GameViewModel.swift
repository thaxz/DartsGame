//
//  GameViewModel.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import CoreData

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
    
    var match: MyMatch?
    
    var startTime: Date? = nil
    var endTime: Date? = nil
    var points: Int = 0
    
    func gameOver(){
        isGameOver = true
        endTime = Date()
        createMatch()
    }
    
    func updateDartResult(at index: Int) {
        guard index >= 0, index < dartResults.count else {
            return // Índice fora do intervalo do array
        }
        dartResults[index] = true // Substitui o valor no índice especificado
    }
    
    // mock match
    func createMatch(){
        guard let endTime = endTime,
              let startTime = startTime else {
            return
        }
        let timePassed = calculateDifferenceString(between: startTime, and: endTime)
        
        self.match = MyMatch(id: 3, points: self.points, dartStatus: boolArrayToString(dartResults), timePassed: timePassed)
    }
    
    //MARK: CORE DATA
    
    // Fetch
    func fetchMatches(){
        // creating request
        let request = NSFetchRequest<Match>(entityName: "Match")
        // making the request
        do {
            // saving in a place that our views are subscribed to
            matches = try manager.context.fetch(request)
        } catch {
            print("error fetching \(error)")
        }
    }
    
    // Create
    func addMatch(points: Int, dartStatus: String, timePassed: String){
        let newMatch = Match(context: manager.context)
        newMatch.id = Int16(matches.count + 1)
        newMatch.points = Int16(points)
        newMatch.timePassed = timePassed
        newMatch.dartStatus = dartStatus
        saveData()
    }
    
    // SAVE
    func saveData(){
        manager.save()
        fetchMatches()
    }
    
    //MARK: MATCH LOGIC
    
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
