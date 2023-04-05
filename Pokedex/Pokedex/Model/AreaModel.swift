//
//  AreaModel.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import Foundation

struct AreaModelElement: Codable {
    let locationArea: LocationArea

    enum CodingKeys: String, CodingKey {
        case locationArea = "location_area"
    }
}

// MARK: - LocationArea
struct LocationArea: Codable {
    let name: String
    let url: String
}

typealias AreaModel = [AreaModelElement]
