//
//  JSONConfig.swift
//  Pokedex
//
//  Created by mmbs on 05/04/23.
//

import Foundation

public class JsonConfig {
    
    
    func manageJSONFile(value: PokemonData, isDelete: Bool) {
        let fileName = "my-pokemon.json"
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else {
            fatalError("Failed to get file URL")
        }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            // The file exists, so we can read its contents
            print("File found!")
            guard let data = try? Data(contentsOf: fileURL) else {
                fatalError("Failed to read file data")
            }
            var objects = [PokemonData]()
            let decoder = JSONDecoder()
            if let decodedObjects = try? decoder.decode([PokemonData].self, from: data) {
                objects = decodedObjects
            } else {
                fatalError("Failed to decode JSON data")
            }
            if (isDelete) {
                if let index = objects.firstIndex(where: {$0.name == value.name}) {
                    objects.remove(at: index)
                }
            } else {
                objects.append(value)
            }
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            guard let updatedData = try? encoder.encode(objects) else {
                fatalError("Failed to encode updated objects to JSON")
            }

            // Write the updated JSON data back to the file
            do {
                try updatedData.write(to: fileURL)
                print("JSON file saved successfully at \(fileURL)")
            } catch {
                fatalError("Failed to write updated JSON data to file: \(error.localizedDescription)")
            }
        } else {
            // The file does not exist, so we need to create it
            print("File not found!")
            let encoder = JSONEncoder()
            var pokemonArray = [PokemonData]()
            pokemonArray.append(value)
            do {
                let jsonData = try encoder.encode(pokemonArray)
                try jsonData.write(to: fileURL)
                print("JSON file saved successfully at \(fileURL)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getJsonData() -> [PokemonData] {
        let fileName = "my-pokemon.json"
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) else {
            fatalError("Failed to get file URL")
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Failed to read file data")
        }
        var objects = [PokemonData]()
        let decoder = JSONDecoder()
        if let decodedObjects = try? decoder.decode([PokemonData].self, from: data) {
            objects = decodedObjects
        } else {
            fatalError("Failed to decode JSON data")
        }
        return objects
    }
    
}
