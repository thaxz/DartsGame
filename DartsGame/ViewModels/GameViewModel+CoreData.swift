//
//  GameViewModel+CoreData.swift
//  DartsGame
//
//  Created by thaxz on 18/10/23.
//

import Foundation
import CoreData

//MARK:  CORE DATA

extension GameViewModel {
    
    // Fetch
    func fetchMatches(){
        let request = NSFetchRequest<Match>(entityName: "Match")
        do {
            matches = try manager.context.fetch(request)
        } catch {
            print("error fetching \(error)")
        }
    }
    
    // Create
    func createMatch(){
        guard let endTime = endTime,
              let startTime = startTime else {
            return
        }
        let newMatch = Match(context: manager.context)
        newMatch.id = Int16(matches.count + 1)
        newMatch.points = Int16(self.points)
        newMatch.timePassed = calculateDifferenceString(between: startTime, and: endTime)
        newMatch.dartStatus = boolArrayToString(dartResults)
        self.match = newMatch
        saveData()
    }
    
    // SAVE
    func saveData(){
        manager.save()
        fetchMatches()
    }
    
    
}
