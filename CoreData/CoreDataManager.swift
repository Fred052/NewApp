//
//  CoreDataManager.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 22.08.26.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewApp")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load Core Data: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
