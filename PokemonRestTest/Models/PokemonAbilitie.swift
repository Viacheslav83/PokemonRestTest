//
//  PokemonAbilitie.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 31.05.2021.
//

import Foundation

// MARK: - PokemonAbilitie
struct PokemonAbilitie: Codable {
    let effectEntries: [Item]
    
    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
    }
}

// MARK: - Item
struct Item: Codable {
    let effect: String
    let shortEffect: String
    
    enum CodingKeys: String, CodingKey {
        case effect
        case shortEffect = "short_effect"
    }
}
