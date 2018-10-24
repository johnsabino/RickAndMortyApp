//
//  MakeFavorite.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 24/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

extension FavoriteChar {
    convenience init(withName: String, gender: String, location: String, origin: String, specie: String, type: String, status: String, imagePath: String){
        
        self.init(context: CoreDataManager.persistentContainer.viewContext)
        self.name = withName
        self.gender = gender
        self.location = location
        self.origin = origin
        self.specie = specie
        self.type = type
        self.status = status
        
        CoreDataManager.saveContext()
    }
}

class MakeFavorite {
    
    func saveToFavorites(){
        
    }
}
