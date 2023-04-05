//
//  SpeciesModel.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import Foundation

// MARK: - SpeciesModel
struct SpeciesModel: Codable {
    let color: DataSpecies
    let eggGroups: [DataSpecies]
    let flavorTextEntries: [FlavorTextEntry]


    enum CodingKeys: String, CodingKey {
        case color
        case eggGroups = "egg_groups"
        case flavorTextEntries = "flavor_text_entries"
    }
}

// MARK: - Data
struct DataSpecies: Codable {
    let name: String
    let url: String
}

// MARK: - EvolutionChain
// MARK: - FlavorTextEntry
struct FlavorTextEntry: Codable {
    let flavorText: String
    let language, version: DataSpecies

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}
