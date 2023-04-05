//
//  Service.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import Moya
import ConfigKit

public enum Service {
    case pokemonList(offset: Int, limit: Int)
    case pokemonType(pokemonID: Int)
    case species(pokemonID: Int)
    case location(pokemonID: Int)
}

extension Service: TargetType {
    
    public var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    
    public var path: String {
        switch self {
        case .pokemonList:
            return "pokemon"
        case .pokemonType(pokemonID: let pokemonID):
            return "pokemon-form/\(pokemonID)"
        case .species(pokemonID: let pokemonID):
            return "pokemon-species/\(pokemonID)"
        case .location(pokemonID: let pokemonID):
            return "pokemon/\(pokemonID)/encounters"
            
        }
    }
    
    public var headers: [String : String]? {
        return ["Accept": "*/*"]
    }
    
    public var sampleData : Data {
        return Data()
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .pokemonList(offset: let offset, limit: let limit):
            return .requestParameters(parameters: ["offset": offset, "limit" : limit], encoding: URLEncoding.queryString)
        case .pokemonType(pokemonID: _), .species(pokemonID: _), .location(pokemonID: _):
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
}
