//
//  PokemonService.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 01.06.2021.
//

import Foundation

class PokemonService {
    typealias ServiceResult = Result<PokemonItem, APIError>
    
    static var urlString = "https://pokeapi.co/api/v2/pokemon?limit=20"
    
    static func getURLString(with string: String?) {
        urlString = string ?? urlString
    }
    
    static func fetchPokemon(completion: @escaping (ServiceResult) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        Service.getPokemons(with: request, completion: completion)
    }
    
    static func fetchPokemonActivity(with urlString: String,
                                     completion: @ escaping (Result<PokemonAbilitie, APIError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        Service.getAbilitiesPokemon(with: request, completion: completion)
    }
}
