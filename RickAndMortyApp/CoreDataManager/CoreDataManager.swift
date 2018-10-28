//
//  CoreDataManager.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 24/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RickAndMortyApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    static func fetch<T>(_ request: NSFetchRequest<T>) -> [T]{
        do{
            let result = try persistentContainer.viewContext.fetch(request)
            return result
        } catch{
            print(error)
            return [T]()
        }
    }
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
