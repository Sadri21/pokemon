//
//  PokemonModel.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import Foundation

public struct PokemonModel: Codable {
    let count: Int
    let next, previous: String?
    let results: [PokemonData]
}

// MARK: - Result
public struct PokemonData: Codable {
    let name: String
    let url: String
}
