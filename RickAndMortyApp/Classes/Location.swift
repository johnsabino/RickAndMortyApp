//
//  Location.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 18/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

class Location : Codable {
    
    var created : String?
    var dimension : String?
    var id : Int?
    var name : String?
    var residents : [String]?
    var type : String?
    var url : String?
    
    enum CodingKeys: String, CodingKey {
        case created = "created"
        case dimension = "dimension"
        case id = "id"
        case name = "name"
        case residents = "residents"
        case type = "type"
        case url = "url"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        dimension = try values.decodeIfPresent(String.self, forKey: .dimension)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        residents = try values.decodeIfPresent([String].self, forKey: .residents)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    init(){ }
    
}
