//
//  RootClass.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 18/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

class RootRequest<T: Codable>: Codable {
    
    let info : Info?
    let characters : [T]?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case characters = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try values.decodeIfPresent(Info.self, forKey: .info)
        characters = try values.decodeIfPresent([T].self, forKey: .characters)
    }
    
}


