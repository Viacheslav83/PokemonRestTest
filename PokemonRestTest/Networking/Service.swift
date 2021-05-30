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
    
    static func getPokemons(_ completion: @escaping (Result<PokemonItem, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            
            if let pokemonResponse = response as? HTTPURLResponse,
               (400...500).contains(pokemonResponse.statusCode) {
                print(pokemonResponse.statusCode)
                completion(.failure(error as! Error))
                return
            }
            
            if let data = data {
                do {
                    let jsonPokemon = try JSONDecoder().decode(PokemonItem.self, from: data)
                    completion(.success(jsonPokemon))
                } catch let dataError {
                    print("We can not fetch data")
                    completion(.failure(dataError))
                }
            }
        }.resume()
        
    }
}
