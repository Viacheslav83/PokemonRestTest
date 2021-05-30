//
//  PokemonItem.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 30.05.2021.
//

import Foundation

struct PokemonItem: Codable {
    let next: String?
    let previous: String?
    let results: [Pokemon]
}
