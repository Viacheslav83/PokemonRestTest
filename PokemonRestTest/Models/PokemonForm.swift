//
//  PokemonForm.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 02.06.2021.
//

import Foundation

// MARK: - PokemonForm
struct PokemonForm: Codable {
    let sprites: Sprites
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault: String
    let backShiny: String
    let frontDefault: String
    let frontShiny: String

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
