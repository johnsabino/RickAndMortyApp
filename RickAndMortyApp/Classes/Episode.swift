//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 19/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation


class Episode : Codable {
    
    var airDate : String?
    var characters : [String]?
    var created : String?
    var episode : String?
    var id : Int?
    var name : String?
    var url : String?
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case characters = "characters"
        case created = "created"
        case episode = "episode"
        case id = "id"
        case name = "name"
        case url = "url"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airDate = try values.decodeIfPresent(String.self, forKey: .airDate)
        characters = try values.decodeIfPresent([String].self, forKey: .characters)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        episode = try values.decodeIfPresent(String.self, forKey: .episode)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    init() {}
    
}
