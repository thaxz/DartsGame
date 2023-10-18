//
//  CoreDataManager.swift
//  DartsGame
//
//  Created by thaxz on 18/10/23.
//

import Foundation
import CoreData

// MARK: A singleton class responsible for managing Core Data
class CoreDataManager: ObservableObject {
    
    /// Singleton
    static let shared = CoreDataManager()
    
    /// Persistence objects
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    /// Initializes the Core Data manager and sets up the persistent container.
    init(){
        container = NSPersistentContainer(name: "MatchesContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    /// Save changes
    func save(){
        do {
            try context.save()
        } catch(let error){
            print("Error saving core data \(error.localizedDescription)")
        }
    }
}
