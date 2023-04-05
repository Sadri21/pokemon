//
//  ViewModel.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import Foundation
import Moya

class ViewModel: NSObject {
    
    let moyaProvider = MoyaProvider<Service>(plugins: [NetworkLoggerPlugin()])
    var isLoading: ((Bool) -> Void)?
    var message: ((String) -> Void)?
    var pokemon: ((PokemonModel) -> Void)?
    var pokemonDetail: ((DetailModel) -> Void)?
    var species: ((SpeciesModel) -> Void)?
    var areas: (([AreaModelElement]) -> Void)?
    
    func getPokemon(offset: Int, limit: Int) {
        isLoading?(true)
        moyaProvider.request(.pokemonList(offset: offset, limit: limit)) { [self] result in
            switch result {
            case .success(let response):
                isLoading?(false)
                if (response.statusCode == 200) {
                    do {
                        let data = try JSONDecoder().decode(PokemonModel.self, from: response.data)
                        pokemon?(data)
                    } catch {
                        message?(error.localizedDescription)
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                message?(error.localizedDescription)
                print(error.localizedDescription)
                isLoading?(false)
            }
        }
    }
    
    func getPokemonDetail(pokemonID: Int) {
        isLoading?(true)
        moyaProvider.request(.pokemonType(pokemonID: pokemonID)) { [self] result in
            switch result {
            case .success(let response):
                isLoading?(false)
                if (response.statusCode == 200) {
                    do {
                        let data = try JSONDecoder().decode(DetailModel.self, from: response.data)
                        pokemonDetail?(data)
                    } catch {
                        message?(error.localizedDescription)
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                message?(error.localizedDescription)
                print(error.localizedDescription)
                isLoading?(false)
            }
        }
    }
    
    func getPokemonSpecies(pokemonID: Int) {
        isLoading?(true)
        moyaProvider.request(.species(pokemonID: pokemonID)) { [self] result in
            switch result {
            case .success(let response):
                isLoading?(false)
                if (response.statusCode == 200) {
                    do {
                        let data = try JSONDecoder().decode(SpeciesModel.self, from: response.data)
                        species?(data)
                    }
                    catch {
                        message?(error.localizedDescription)
                        print(error.localizedDescription)
                    }
                        
                   
                }
            case .failure(let error):
                message?(error.localizedDescription)
                print(error.localizedDescription)
                isLoading?(false)
            }
        }
    }
    
    func getPokemonArea(pokemonID: Int) {
        isLoading?(true)
        moyaProvider.request(.location(pokemonID: pokemonID)) { [self] result in
            switch result {
            case .success(let response):
                isLoading?(false)
                if (response.statusCode == 200) {
                    do {
                        let data = try JSONDecoder().decode(AreaModel.self, from: response.data)
                        areas?(data)
                    } catch {
                        message?(error.localizedDescription)
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                message?(error.localizedDescription)
                print(error.localizedDescription)
                isLoading?(false)
            }
        }
    }
}
