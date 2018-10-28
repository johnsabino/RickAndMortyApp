//
//  MakeFavorite.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 24/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation
import CoreData

extension FavoriteChar {
    convenience init(char: Character){
        
        self.init(context: CoreDataManager.persistentContainer.viewContext)
        
        if let idStr = char.id {
            self.id = String(idStr)
        }
        
        self.name = char.name
        self.gender = char.gender
        self.location = char.location?.name
        self.origin = char.origin?.name
        self.specie = char.species
        self.type = char.type
        self.status = char.status
        
        CoreDataManager.saveContext()
    }
}

class MakeFavorite {
    
    func fetchFavoriteChar() -> [FavoriteChar]{
        let fetch : NSFetchRequest<FavoriteChar> = FavoriteChar.fetchRequest()
        let favoriteChars = CoreDataManager.fetch(fetch)
        
        return favoriteChars
    }
}
