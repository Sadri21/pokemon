//
//  DetailModel.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import Foundation

struct DetailModel: Codable {
    let formOrder, id: Int
    let isBattleOnly, isDefault, isMega: Bool
    let name: String
    let order: Int
    let types: [TypeElement]

    enum CodingKeys: String, CodingKey {
        case formOrder = "form_order"
        case id
        case isBattleOnly = "is_battle_only"
        case isDefault = "is_default"
        case isMega = "is_mega"
        case name, order, types
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: TypeType
}

// MARK: - TypeType
struct TypeType: Codable {
    let name: String
    let url: String
}
