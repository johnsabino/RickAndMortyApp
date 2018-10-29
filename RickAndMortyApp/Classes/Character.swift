//
//  Character.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 18/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation
import UIKit

class Character : Codable {
    
    var created : String?
    var episode : [String]?
    var gender : String?
    var id : Int?
    var image : String?
    var imageFilePath : String?
    var uiImage : UIImage?
    var location : Location?
    var name : String?
    var origin : Origin?
    var species : String?
    var status : String?
    var type : String?
    var url : String?
    
    enum CodingKeys: String, CodingKey {
        case created = "created"
        case episode = "episode"
        case gender = "gender"
        case id = "id"
        case image = "image"
        case location = "location"
        case name = "name"
        case origin = "origin"
        case species = "species"
        case status = "status"
        case type = "type"
        case url = "url"
    }
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        created = try values.decodeIfPresent(String.self, forKey: .created)
        episode = try values.decodeIfPresent([String].self, forKey: .episode)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        origin = try values.decodeIfPresent(Origin.self, forKey: .origin)
        species = try values.decodeIfPresent(String.self, forKey: .species)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
    init() {
        
    }
    
}


