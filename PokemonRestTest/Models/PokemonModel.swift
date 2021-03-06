//
//  PokemonModel.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 30.05.2021.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    let name: String
    let urlString: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case urlString = "url"
    }
}

// MARK: - PokemonItem
struct PokemonItem: Codable {
    let next: String?
    let previous: String?
    let results: [Pokemon]
}
