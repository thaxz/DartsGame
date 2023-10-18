//
//  CoreDataManager.swift
//  DartsGame
//
//  Created by thaxz on 18/10/23.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    
    let container: NSPersistentContainer
    // To store our entities
    @Published var savedMatches: [Match] = []
    
    init() {
        // linking and loading our container
        self.container = NSPersistentContainer(name: "MacthesContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                // handle error
                print("error loading core data \(error.localizedDescription)")
            }
        }
        fetchMatches()
    }
    
    // MARK: Fetch
    func fetchMatches(){
        // creating request
        let request = NSFetchRequest<Match>(entityName: "Match")
        // making the request
        do {
            // saving in a place that our views are subscribed to
            savedMatches = try container.viewContext.fetch(request)
        } catch {
            print("error fetching \(error)")
        }
    }
    
    // MARK: Create
    func addMatch(points: Int, dartStatus: String, timePassed: String){
        let newMatch = Match(context: container.viewContext)
        newMatch.id = Int16(savedMatches.count + 1)
        newMatch.points = Int16(points)
        newMatch.timePassed = timePassed
        newMatch.dartStatus = dartStatus
        saveData()
    }

    //MARK: SAVE
    func saveData(){
        do {
            try container.viewContext.save()
            // Calling this function again to update our published var, since we're not inside a view and arent able to use @FetchRequest to have updated in realtime
            fetchMatches()
        } catch let error {
          print("error saving \(error)")
        }
    }
}
