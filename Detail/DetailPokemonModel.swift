//
//  DetailPokemonModel.swift
//  pokeapi
//
//  Created by Luis Fernandez Rodriguez on 22/04/2026.
//

import Foundation
import UIKit

struct type: Codable{
    let name: String
    let url: String
}

struct types: Codable{
    let type: type
}

struct DetailPokemonModel: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [ApiNetwork.types]
    let image: String
}

