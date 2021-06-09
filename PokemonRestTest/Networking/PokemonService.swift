//
//  PokemonService.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 01.06.2021.
//

import Foundation

class PokemonService {
    typealias ServiceResult<T> = Result<T, APIError>
    
    static var urlString = "https://pokeapi.co/api/v2/pokemon?limit=20"
    
    static func getURLString(with string: String?) {
        urlString = string ?? urlString
    }
    
    static func fetchPokemon(completion: @escaping (ServiceResult<PokemonItem>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        Service.getService(with: request, completion: completion)
    }
    
    static func fetchPokemonActivity(with urlString: String,
                                     completion: @ escaping (ServiceResult<PokemonAbilitie>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        Service.getService(with: request, completion: completion)
    }
    
    static func fetchImagePokemon(with urlString: String,
                                  completion: @escaping (ServiceResult<PokemonForm>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        Service.getService(with: request, completion: completion)
    }
}
