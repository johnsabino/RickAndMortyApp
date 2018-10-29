//
//  SendInstance.swift
//  RickAndMortyApp
//
//  Created by João Paulo de Oliveira Sabino on 28/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

protocol SendInstanceDelegate {
    func sendCharacter() -> Character
    func sendEpisode() -> Episode
    func sendLocation() -> Location
}
