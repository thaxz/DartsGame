//
//  CoreDataManager.swift
//  DartsGame
//
//  Created by thaxz on 18/10/23.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    
    static let shared = CoreDataManager()
    
    // Persistence objects
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "MatchesContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    
    // MARK: Save
    func save(){
        do {
            try context.save()
        } catch(let error){
            print("Error saving core data \(error.localizedDescription)")
        }
    }
}
