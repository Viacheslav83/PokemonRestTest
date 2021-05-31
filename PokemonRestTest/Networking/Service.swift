//
//  Service.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 30.05.2021.
//

import Foundation

class Service {
    
    static var urlString = "https://pokeapi.co/api/v2/pokemon?limit=10"
    
    static func getURLString(with string: String) {
        urlString = string
    }
    
    static func getPokemons(_ completion: @escaping (Result<PokemonItem, APIError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.server(error)))
                }
                return
            }
            
            if let pokemonResponse = response as? HTTPURLResponse,
               (400...500).contains(pokemonResponse.statusCode) {
                DispatchQueue.main.async {
                    completion(.failure(.response(pokemonResponse.statusCode)))
                }
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let jsonPokemon = try JSONDecoder().decode(PokemonItem.self, from: data)
                        completion(.success(jsonPokemon))
                    } catch {
                        completion(.failure(.wrongType(String(describing: PokemonItem.self))))
                    }
                } else {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }
}
