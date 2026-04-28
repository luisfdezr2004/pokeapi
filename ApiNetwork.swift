//
//  ApiNetwork.swift
//  pokeapi
//
//  Created by Luis Fernandez Rodriguez on 22/04/2026.
//

import Foundation
import UIKit

class ApiNetwork {
    struct Wrapper: Codable{
        let results: [Pokemon]
    }
    
    struct Pokemon: Codable {
        let name: String
        let url: String
    }
    
    struct type: Codable{
        let name: String
        let url: String
    }
    
    struct types: Codable{
        let type: type
    }
    
    struct pokemonDetail: Codable{
        let name: String
        let height: Int
        let weight: Int
        let types: [types]
    }
    struct swordShield: Codable{
        let name_icon: String
    }
    
    struct generationViii: Codable{
        let swordShield : swordShield
        enum CodingKeys: String, CodingKey {
            case swordShield = "sword-shield"
        }
    }
    
    struct sprites: Codable{
        let generationViii: generationViii
        
        enum CodingKeys: String, CodingKey {
            case generationViii = "generation-viii"
        }
    }
    
    
    struct typeDetail: Codable{
        let sprites: sprites
    }

    func getPokemons(limit: Int, offset: Int) async throws-> Wrapper{
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")
        let (data, _) = try await URLSession.shared.data(from: url!)
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
        return wrapper
    }
    
    func getPokemonById(id: Int) async throws-> pokemonDetail{
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")
        let (data, _) = try await URLSession.shared.data(from: url!)
        let pokemon = try JSONDecoder().decode(pokemonDetail.self, from: data)
        return pokemon
    }
    func getTypeSprite(id: Int) async throws -> typeDetail{
        let url = URL(string: "https://pokeapi.co/api/v2/type/\(id)")
        let (data, _) = try await URLSession.shared.data(from: url!)
        let type = try JSONDecoder().decode(typeDetail.self, from: data)
        return type
    }

}
